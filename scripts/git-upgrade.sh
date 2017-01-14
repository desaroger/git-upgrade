#!/bin/bash

function checkHttpStatus {
    status=$(curl --write-out %{http_code} --silent --output /dev/null "$1")
    [ "$status" == "200" ]
    return
}

if [ $# -ne 1 ]; then
    echo Usage: git-upgrade [repository]
    echo Example: git-upgrade desaroger@loopback-i18n
    exit 1
fi

if [[ $1 != *"@"* ]]; then
  echo "Invalid repository. Format: [user]@[repo]"
  echo Example: git-upgrade desaroger@loopback-i18n
  exit 1
fi

repo=$1
githubUrl="https://github.com/${repo/@//}"
url="git@github.com:${repo/@//}.git"

if ! checkHttpStatus $githubUrl; then
    echo "Repository not found [not 200 response]"
    exit 1
fi

cd /var/tmp

# Clone repo if empty
echo Cloning...
# rm -rf $repo
git clone $url $repo &> /dev/null
cd $repo
git checkout package.json &> /dev/null
echo Pulling...
git pull &> /dev/null

# Upgrade
echo Checking for upgrading...
npm upgrade --save &> /dev/null
git add package.json

# Check for changes
if git diff --cached --exit-code package.json &> /dev/null; then
    echo Nothing to upgrade
else
    echo Patching...
    npm version patch
    git push
    echo Package upgrated
fi
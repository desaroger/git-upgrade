#!/bin/bash
repo=$1
url="git@github.com:${repo/@//}.git"

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
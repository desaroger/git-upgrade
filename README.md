
# Git-upgrade

Git-upgrade is a utility for keep your github repositories with the dependencies updated. It basically do `npm upgrade --save` and if there is changes, do a `npm version patch` and push the changes.

Author: Roger Fos Soler (desaroger23@gmail.com)

## Usage

First, install the library:

```bash
$ npm i -g git-upgrade
```

Now you have a cli utility called `git-upgrade`. Usage:

```bash
$ git-upgrade [repository]
```

Example:

```bash
$ git-upgrade desaroger@loopback-i18n
```

It will create a temporal folder, clone the repo, etc. You can run this command on any place, as it does nothing with the current folder.
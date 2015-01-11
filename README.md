# svn-notifier
Script to notify when a working copy of an svn repository is outdated. For now it is just for personal use.

# Installation
## Mac OSX
Open your terminal app, and go to your bin directory:
```
$ cd ~/.bin
```

**Install with Git:**
Clone the repository to **svn_notify_wc**:
```
$ git clone https://github.com/MalcolmK/svn-notifier.git
```

**Note:** The notifier can be updated by running: `cd ~/.bin; git pull; chmod +x notifier.sh`.

##Make it work globally:

```
$ chmod +x svn_notify_wc/notifier.sh
$ ln -sf $PWD/svn_notify_wc/notifier.sh svn-notifier-wc
```

# Uninstall
## Mac OS X
Unstalling can be done by deleting the folder and the symlink:
```
$ rm -rf ~/.bin/svn_notifier_wc
$ rm -f ~/.bin/svn-notifier-wc
```

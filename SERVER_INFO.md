# SVN Server Info
This document contains information on how to run the SVN server.

## Useful Commands
- `getent group` - Lists out all the groups and the associated users.
- `usermod -a -G <group> <user>` - Add user to group.
- `deluser <username> <group>` - Delete user from group
- `htpasswd -D <path to passwd file> <user>` - Delete user from SVN access
- `deluser <user>` - Delete user from system

- `sudo chown -R root:subversion <repository_directory>` - Change the ownership of the subversion directory.
- `sudo chmod -R g+rws <repository_directory>` - Ensure that the directory has the correct permissions.

## Creating New Groups
- `groupadd <group>`
- `groupmod <group> -n <newName>`

## Creating New SVN Directory
To create a SVN directory you first need to create it and then check it out in order to make it a working copy. You also need to set up the correct ownership.

1. `svnadmin create <directory>`

2. `svn co <URL to that directory> <directory> --username <username>`

3. `sudo chown -R root:subversion <directory>`

**Example**
`svnadmin create test`
`svn co http://159.203.250.30/test/ test --username tyu`

**Source:** https://bdhacker.wordpress.com/2012/01/11/create-svn-repository-in-ubuntu-access-via-http/

## Location of Useful Files
`/etc/apache2/`

## Changes to WebDAV Info
Anytime changes are made to apache .conf files, the server needs to be restarted/reloaded.
- `sudo service apache2 reload`
- `sudo /etc/init.d/apache2 restart`

## Links to SVN Locking Info
- https://tortoisesvn.net/docs/release/TortoiseSVN_en/tsvn-dug-locking.html

## General SVN Info
- http://gotofritz.net/blog/howto/svn-status-codes/

There is a pre-commit script that checks if new files have the needs-lock property.
If not, the commit does not go through.

May need to add another pre-commit check to see if user performing the commit has the lock for the specified file.

**Note:** It is not recommended to perform any other SVN commands within start/pre/post hooks because:

1. The client would not know of the changes and would run into issues when they try to commit again.

2. You have to have some way to pass user credentials to the hooks. Currently there is no way to do so.

## Permissions
There are two sets of permissions in the server:

1. Accessing SVN repo via web
  - Passwords can be found in `/home/svn/.htpasswd`.
  - When accessing the server via a browser, a popup should appear asking for a username and password. To change the prompt message, look at `/home/svn/.htaccess`.

2. Permissions for checking out files
  - There are two SVN groups in `/etc/group`. You need to set the permissions per file/directory in order for one to check out the files in that directory.
  - Need to set per file/directory
  - The groups allowed to SSH into server can be found in: `/etc/ssh/sshd_config` - AllowGroups
 
## Current State
- Only users in the svn-admin group can access files from a browser or over SSH.
 - see `/etc/ssh/sshd_config`
 - Once you make changes there, you must restart ssh for the changes to take effect: `sudo service ssh restart`
 
All user created scripts are kept in `/usr/local/bin/`.
(Explanation: http://askubuntu.com/questions/308045/differences-between-bin-sbin-usr-bin-usr-sbin-usr-local-bin-usr-local)
 
All aliases are kept in `/etc/profile.d/`
 
## SVN User Setup
The following steps should be followed to get a user started:

1. Get user to download TortoiseSVN: https://tortoisesvn.net/downloads.html

2. Create an SVN account for the user.

3. SVN Checkout one or more of the respositories from the URL.

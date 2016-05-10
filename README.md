# Server Scripts
This repo contains a variety of scripts for configuring the server.

## Contents
/svn/hooks/checkNeedsLock.py - A pre-commit script that checks if all the new files have the "svn:needs-lock" property.

/svn/init/createHookSymlinks.py - Script that sets up symlinks in the /hooks/ directory of a repository.

/svn/init/aliases/cpalias.sh - Alias to copy an edited alias to the /etc/profile.d/ directory and source that edited alias.

/svn/init/aliases/deleteuser.sh - Removes a user's SSH and SVN access. Also deletes their /home/ directory.

/svn/init/aliases/newuser.sh - Creates a new user with SSH and SVN access(es).

/svn/init/aliases/svncreate.sh - Alias that creates a new SVN repository and creates symlinks to a variety of hook scripts.

# Scripts TODO
- Other SVN configuration scripts
- Generic Apache/WebDAV startup/setup script (not sure if needed, can just use: /etc/init.d/apache2 restart)
- Write hook script to prevent non-privileged users from deleting files

## What to Still Test
The following are scenarios that have not been tested with the SVN hooks I wrote:
- User creates new repository and commits it
  - Test creating from server
  - Test creating from local machine
- User pulls an existing repository
  - All files should be read-only
- User adds files
  - By default they should have a lock on it

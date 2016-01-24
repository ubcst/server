# Server Scripts
This repo contains a variety of scripts for configuring the server.

## Contents
/svn/hooks/checkNeedsLock.py - A pre-commit script that checks if all the new files have the "svn:needs-lock" property.

/svn/init/createHookSymlinks.py - Script that sets up symlinks in the /hooks/ directory of a repository.

/svn/init/aliases/svncreate.sh - Alias that creates a new SVN repository and creates symlinks to a variety of hook scripts.

# Scripts TODO
- User creation script
- Other SVN configuration scripts
- Generic Apache/WebDAV startup/setup script

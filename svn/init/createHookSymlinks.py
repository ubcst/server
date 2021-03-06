#!/usr/bin/python

"""
 " Creates symlinks in the "hooks/" directory of a repository that point to
 " the actual scripts in another directory.
"""

import sys, os

# Get args
if len( sys.argv ) < 3:
   print "error: incorrect number of arguments"
   print "usage: python createHookSymlinks.py <repository_dir> <source_dir>"
   print "\t<repository_dir> - The root directory of the repository."
   print "\t<source_dir> - The directory where the hook scripts are located."
   sys.exit( 0 )

repoDir = sys.argv[1]
sourceDir = sys.argv[2]

# Get list of all files in the sourceDir
output = os.popen( "ls " + sourceDir ).read()
files = output.split()

# Make sure that the entered directory locations end with a '/' character
if not repoDir.endswith( '/' ):
   repoDir = repoDir + '/'
if not sourceDir.endswith( '/' ):
   sourceDir = sourceDir + '/'

# Create symlinks
for fd in files:
   symlinkPath = repoDir + "hooks/" + fd

   # If the symlink already exists, we delete it
   if os.path.exists(symlinkPath):
      os.system( "rm -rf " + symlinkPath )

   os.system( "ln -s " + sourceDir + fd + " " + symlinkPath )

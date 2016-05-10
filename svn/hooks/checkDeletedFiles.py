#!/usr/bin/python

"""
 " Simple script that checks if the user is allowed to delete files.
"""

import sys, os

"""
 " Takes in the output of an svn command (e.g. "svn update",
 " "svnlook changed -r <rev> <repos>" and returns a list of
 " deleted files.
"""
def getDeletedFiles( output ):
   files = []
   changedFiles = cmdOutput.split("\n")
   for changedFile in changedFiles:
      fd = changedFile.split()
      if len(fd) <= 0:
         continue

      # Check if item is a deleted item
      # Assuming that the status is the first item after splitting
      if "D" != fd[0]:
         continue

      # Check if newly added item is a new directory
      deletedFile = fd[-1]
      if deletedFile.endswith('/'):
         continue

      # Reconstruct file name
      deletedFile = "\""
      for i in range(1, len(fd)):
         deletedFile = deletedFile + fd[i]
         if i != (len(fd) - 1):
            deletedFile = deletedFile + " "
      deletedFile = deletedFile + "\""

      files.append( deletedFile )
   return files

# Check if the correct number of args is passed
if len( sys.argv ) < 3:
   ret = "Incorrect number of args."
   sys.exit( ret )

repos = sys.argv[1]
txn = sys.argv[2]

# Check what files are changed/added/deleted
cmdOutput = os.popen( "svnlook changed -t " + txn + " " + repos ).read()
print cmdOutput
newFiles = getNewFiles( cmdOutput )

cmdOutput = os.popen( "svnlook author -t " + txn + " " + repos ).read()
print cmdOutput
if len(newFiles) > 0:
   privilegedUsers

# If there are files that aren't locked, return a message to get the user to
# lock the file.
if fileList:
   ret = "To ensure only one user makes changes to the files you changed, " + \
         "please set the needs-lock property for the following files:" + \
         fileList
   sys.exit( ret )

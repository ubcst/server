#!/usr/bin/python

"""
 " Simple script that checks the "svn:needs-lock" property for every
 " new file. If the property is not set, then the commit is blocked.
 " Note: May move the functions to a library Python file.
"""

import sys, os

"""
 " Takes in the output of an svn command (e.g. "svn update",
 " "svnlook changed -r <rev> <repos>" and returns a list of
 " newly added files.
"""
def getNewFiles( output ):
   files = []
   changedFiles = cmdOutput.split("\n")
   for changedFile in changedFiles:
      fd = changedFile.split()
      if len(fd) <= 0:
         continue

      # Check if item is a new item
      # Assuming that the status is the first item after splitting
      if "A" != fd[0]:
         continue

      # Check if newly added item is a new directory
      newFile = fd[-1]
      if newFile.endswith('/'):
         continue

      # Reconstruct file name
      newFile = "\""
      for i in range(1, len(fd)):
         newFile = newFile + fd[i]
         if i != (len(fd) - 1):
            newFile = newFile + " "
      newFile = newFile + "\""

      files.append( newFile )
   return files

# Check if the correct number of args is passed
if len( sys.argv ) < 3:
   ret = "Incorrect number of args."
   sys.exit( ret )

repos = sys.argv[1]
txn = sys.argv[2]

# Check what files are changed/added
cmdOutput = os.popen( "svnlook changed -t " + txn + " " + repos ).read()
print cmdOutput
newFiles = getNewFiles( cmdOutput )

# Check the svn:needs-lock property for all new files
fileList = ""
needsLockFiles = []
for newFile in newFiles:
   print newFile
   output = os.popen( "svnlook propget " + repos + " svn:needs-lock " +
                      newFile + " -t " + txn ).read()
   if not output:
      needsLockFiles.append( newFile )
      fileList = "\n- " + fileList + newFile

# If there are files that aren't locked, return a message to get the user to
# lock the file.
if fileList:
   ret = "To ensure only one user makes changes to the files you changed, " + \
         "please set the needs-lock property for the following files:" + \
         fileList
   sys.exit( ret )

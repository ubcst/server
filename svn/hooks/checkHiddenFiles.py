#!/usr/bin/python

"""
 " Simple script that checks whether or not the user is submitting
 " a a file that starts with "~$". If so, a warning is given to open
 " the file.
"""

import sys, os

"""
 " Takes in the output of an svn command (e.g. "svn update",
 " "svnlook changed -r <rev> <repos>" and returns a list of
 " files.
"""
def getFiles( output ):
   files = []
   changedFiles = cmdOutput.split("\n")
   for changedFile in changedFiles:
      fd = changedFile.split()
      if len(fd) <= 0:
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
newFiles = getFiles( cmdOutput )

# Check if the file starts with "~$"
fileList = ""
for newFile in newFiles:
   if newFile.startswith("\"~$"):
      fileList = fileList + " " + newFile.replace("~$", "") + "\n"

if fileList is not "":
   ret = "It seems you might have had a crash with some of the files you " + \
         "added/edited. Please reopen these files, close them and then try " + \
         "committing again:\n" + fileList
   sys.exit( ret )

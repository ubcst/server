#!/usr/bin/python

"""
 " Simple script that checks whether or not the user is submitting
 " a file containing an illegal character (e.g. "$").
"""

import sys, os

illegalChars = [ '*', ':', '\"', '|', '\\', '<', '>', '?', '$',
                 '`' ]

"""
 " Takes in the output of an svn command (e.g. "svn update",
 " "svnlook changed -r <rev> <repos>" and returns a list of
 " files containing illegal characters.
"""
def getIllegalFiles( output ):
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
      for i in range(1, len(fd)):
         newFile = newFile + fd[i]
         if i != (len(fd) - 1):
            newFile = newFile + " "

      # Check the file for illegal characters
      for c in illegalChars:
         if c in newFile:
            files.append( newFile )
            break

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
illegalFiles = getIllegalFiles( cmdOutput )

if len(illegalFiles) > 0:
   ret = "Some of the files you are trying to commit are named with an illegal" + \
         "character. Please rename them and try committing again.\n" + \
         "Illegal characters are: " + " ".join(illegalChars) + "\n" + \
         "The files containing illegal characters are:\n" + \
         "\n".join(illegalFiles)
   sys.exit( ret )

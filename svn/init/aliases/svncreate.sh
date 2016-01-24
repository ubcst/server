#!/bin/sh
# Alias to be used when creating a SVN repository
printUsage() {
    # Print the usage message
    echo "usage: svncreate svnrootdir hookdir"
    echo -e "   svnrootdir:\tThe root directory of the repository"
    echo -e "   hookdir:\tThe directory where the hook scripts are located"
}

svncreate() {
    SVNDIR=$1
    URL="http://159.203.250.30/$SVNDIR"
    HOOKDIR=$2

    # Check the number of arguments passed in
    if [ $# -lt 2 ]; then
        echo "Error: Incorrect number of arguments"
        printUsage
        return
    fi

    # Check if the hook directory exists
    if [ ! -d "$HOOKDIR" ]; then
        echo "Error: Hook directory does not exist"
        printUsage
        return
    fi

    # If the SVN directory does not exist, create it.
    if [ ! -d "$SVNDIR" ]; then
        mkdir $SVNDIR
    fi

    # Create the SVN repository
    svnadmin create $SVNDIR
    svn co $URL $SVNDIR

    # Create symlinks for the hook scripts
    createHookSymlinks.py $SVNDIR $HOOKDIR

    # Change the ownership of the repository to svn-admin
    sudo chown -R root:svn-admin $SVNDIR
}

alias svncreate=svncreate

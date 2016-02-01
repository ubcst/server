#!/bin/sh
# Alias that creates a new SVN repository, and creates symlinks to hook scripts.
svncreate() {
    SVNDIR=$1
    HOOKDIR=$2

    USAGE_STATEMENT="usage: svncreate svnrootdir hookdir\n"
    USAGE_STATEMENT+="   svnrootdir:\tThe root directory of the repository\n"
    USAGE_STATEMENT+="   hookdir:\tThe directory where the hook scripts are located"

    # Check the number of arguments passed in
    if [ $# -lt 2 ]; then
        echo "Error: Incorrect number of arguments"
        echo -e $USAGE_STATEMENT
        return
    fi

    # Check if the hook directory exists
    if [ ! -d "$HOOKDIR" ]; then
        echo "Error: Hook directory does not exist"
        echo -e $USAGE_STATEMENT
        return
    fi

    # If the SVN directory does not exist, create it.
    if [ ! -d "$SVNDIR" ]; then
        mkdir $SVNDIR
    fi

    # Get the IP address. Currently assuming the first item in $IPS is the IP
    IPS="$(hostname -I)"
    for word in $IPS
    do
        IP=$word
        break
    done

    # Get the last part of the SVN directory and not the full path
    SVNDIRNAME="$(basename $SVNDIR)"
    URL="http://$IP/$SVNDIRNAME"

    # Create the SVN repository
    svnadmin create $SVNDIR
    svn co $URL $SVNDIR

    # Create symlinks for the hook scripts
    createHookSymlinks.py $SVNDIR $HOOKDIR

    # Change the ownership of the repository to svn-admin
    sudo chown -R root:svn-admin $SVNDIR

    # Change the file permissions to ensure that new files and directories
    # in the repository will have the same group as the repository owner.
    sudo chmod -R g+rws $SVNDIR
}

alias svncreate=svncreate

#!/bin/sh
# Alias that deletes a user from having SSH and SVN access
# Also deletes their /home/ directory
deleteuser() {
    USAGE_STATEMENT="Deletes a user from having SSH and SVN access and deletes\n"
    USAGE_STATEMENT+="their /home/<username>/ directory\n"
    USAGE_STATEMENT+="   usage: deleteuser username\n"

    HOME_DIR="/home/"
    SVN_PASSWD_DIR="/home/svn/.htpasswd"
    USERNAME=""

    # Check the number of arguments passed in
    if [ $# -lt 1 ]; then
        echo -e "Error: Incorrect number of arguments\n"
        echo -e $USAGE_STATEMENT
        return
    fi

    # Check if user wants help
    if [ $1 = "-h" ] || [ $1 = "--help" ]; then
        echo -e $USAGE_STATEMENT
        return
    fi

    USERNAME=$1

    # Check if user has SSH access and delete their folder
    if [ -d "$HOME_DIR$USERNAME/" ]; then
        echo -e "Deleting $HOME_DIR$USERNAME/"
        sudo rm -rf $HOME_DIR$USERNAME
    fi

    echo -e "Removing SVN access for \`$USERNAME'..."
    sudo htpasswd -D $SVN_PASSWD_DIR $USERNAME
    echo -e "Removing SSH access for \`$USERNAME'..."
    sudo deluser $USERNAME
}

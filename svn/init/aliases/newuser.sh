#!/bin/sh
# Alias that creates user accounts for:
# - Server SSH access
# - SVN access
printUsage() {
    # Print the usage message
    echo "Creates a new SSH and/or SVN user"
    echo -e "usage: newuser (ssh|svnr|svnw)+ username"
    echo -e "   username:\tThe username of the user to add"
    echo -e "   ssh:\t\tCreates a SSH account for the username"
    echo -e "   svnr:\tCreates a SVN account with read access for the username"
    echo -e "   svnw:\tCreates a SVN account with read and write access for the username\n"

    echo -e "Example: newuser ssh svnr test"
    echo -e "Creates \"test\" a SSH account and a SVN account (with only read privileges)\n"
    echo -e "for \"test\"\n"
    echo -e "If user already has a SVN account, the svnr|svnw arguments just add the user\n"
    echo -e "to those groups"
    echo -e "If command does not include svnr|svnw, then the user will be removed from\n"
    echo -e "those groups if they are already a part of them"
}

newuser() {
    SVN_PASSWD_DIR="/home/svn/.htpasswd"
    SVN_READ_GROUP="svn-read"
    SVN_WRITE_GROUP="svn-write"

    SSH=false
    SVNR=false
    SVNW=false
    USERNAME=""
    PASSWORD=""

    # Check the number of arguments passed in
    if [ $# -lt 1 ]; then
        echo "Error: Incorrect number of arguments"
        printUsage
        return
    fi

    while [[ $# > 0 ]]
    do
        key=$1

        case $key in
            ssh)
                SSH=true
            ;;
            svnr)
                SVNR=true
            ;;
            svnw)
                SVNW=true
            ;;
            -h|--help)
                printUsage
                return
            ;;
            *)
                # Last argument not one of the above arguments will be the username
                USERNAME=$key
            ;;
        esac
        shift
    done
    if [ $SVNR = false ] && [ $SVNW = false ] && [ $SSH = false ]; then
        echo "Error: Incorrect format"
        printUsage
        return
    fi

    # Check if the user really wants to give the new user SSH access
    if [ $SSH = true ]; then
        while : ; do
            echo "Are you sure you want to allow \"$USERNAME\" to SSH into the server (y/n)?"
            read response

            case $response in
                [yY]?(es))
                    break
                ;;
                [nN]?(o))
                    return
                ;;
                *)
                ;;
            esac
        done

        # Create a SSH account
        # If that user already exists, the user won't be created
        echo "Creating SSH account for \"$USERNAME\""
        # sudo adduser $USERNAME
        echo "Created SSH account for \"$USERNAME\""
    fi

    # Create SVN account(s)
    # First delete the user if they already have SVN access(es)
    
    # sudo deluser $USERNAME $SVN_READ_GROUP
    # sudo deluser $USERNAME $SVN_WRITE_GROUP
    if [ $SVNR = true ] || [ $SVNW = true ]; then

        # Create the SVN account
        # Check if user already has a SVN account
        HAS_SVN_ACCT="$(grep $USERNAME $SVN_PASSWD_DIR | wc -l)"
        if [ $HAS_SVN_ACCT != 0 ]; then
            echo "Creating SVN account for \"$USERNAME\""
            # sudo htpasswd $SVN_PASSWD_DIR $USERNAME
        fi

        # Add the user to the appropriate group(s)
        # sudo usermod -a -G $SVN_READ_GROUP $USERNAME
        echo "Gave \"$USERNAME\" SVN read access"

        if [ $SVNW = true ]; then
            # sudo usermod -a -G $SVN_WRITE_GROUP $USERNAME
            echo "Gave \"$USERNAME\" SVN write access"
        fi

        echo "Created SVN account for \"$USERNAME\""
    fi
}

#!/bin/sh
# Alias that creates user accounts for:
# - Server SSH access
# - SVN access
printNewUserUsage() {
    # Print the usage message
    echo "Creates a new SSH and/or SVN user"
    echo -e "usage: newuser (ssh|svn)+ username"
    echo -e "   username:\tThe username of the user to add"
    echo -e "   ssh:\t\tCreates a SSH account for the username"
    echo -e "   svn:\t\tCreates a SVN account for the username"

    echo -e "Example: newuser ssh svn test"
    echo -e "Creates \`test' a SSH account and a SVN account for \`test'\n"
    echo -e "If user already has a SVN account, the svn arugment does not do anything"
}

newuser() {
    SVN_PASSWD_DIR="/home/svn/.htpasswd"
    SSH_GROUP="www-data"

    SSH=false
    SVN=false
    USERNAME=""

    # Check the number of arguments passed in
    if [ $# -lt 1 ]; then
        echo "Error: Incorrect number of arguments"
        printNewUserUsage
        return
    fi

    while [[ $# > 0 ]]
    do
        key=$1

        case $key in
            ssh)
                SSH=true
            ;;
            svn)
                SVN=true
            ;;
            -h|--help)
                printNewUserUsage
                return
            ;;
            *)
                # Last argument not one of the above arguments will be the username
                USERNAME=$key
            ;;
        esac
        shift
    done
    if [ $SVN = false ] && [ $SSH = false ]; then
        echo "Error: Incorrect format"
        printNewUserUsage
        return
    fi

    # Check if the user really wants to give the new user SSH access
    if [ $SSH = true ]; then
        while : ; do
            echo "Are you sure you want to allow \`$USERNAME' to SSH into the server (y/n)?"
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
        echo "Creating SSH account for \`$USERNAME'..."
        sudo adduser $USERNAME

        # Add the user to the SSH group
        sudo usermod -a -G $SSH_GROUP $USERNAME
    fi

    # Create SVN account
    if [ $SVN = true ]; then
        echo "Creating SVN account for \`$USERNAME'..."

        # Check if user already has a SVN account
        HAS_SVN_ACCT="$(grep $USERNAME $SVN_PASSWD_DIR | wc -l)"
        if [ "$HAS_SVN_ACCT" = "0" ]; then
            sudo htpasswd $SVN_PASSWD_DIR $USERNAME
        else
            echo "\`$USERNAME' already has an SVN account."
        fi
    fi
}

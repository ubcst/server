#!/bin/sh
# Alias that can be used to copy an alias to the /etc/profile.d/ directory
# Also sources the file so that it can be run right away
cpalias() {
    USAGE_STATEMENT="usage: cpalias aliasfile\n"
    USAGE_STATEMENT+="   aliasfile:\tThe alias file to copy to /etc/profile.d/\n"

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

    FILE=$1

    # Check if the file exists
    if [ ! -e "$FILE" ]; then
        echo -e "Error: File does not exist\n"
        echo -e $USAGE_STATEMENT
        return
    fi

    sudo cp $FILE /etc/profile.d/
    source /etc/profile.d/$FILE

    echo "Alias updated"
}

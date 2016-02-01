#!/bin/sh
# Alias that can be used to copy an alias to the /etc/profile.d/ directory
# Also sources the file so that it can be run right away
cpalias() {
    FILE=$1
    USAGE_STATEMENT="usage: cpalias aliasfile\n"
    USAGE_STATEMENT+="   aliasfile:\tThe alias file to copy to /etc/profile.d/"

    # Check the number of arguments passed in
    if [ $# -lt 1 ]; then
        echo "Error: Incorrect number of arguments"
        echo -e $USAGE_STATEMENT
        return
    fi

    # Check if the file exists
    if [ ! -e "$FILE" ]; then
        echo "Error: File does not exist"
        echo -e $USAGE_STATEMENT
        return
    fi

    sudo cp $FILE /etc/profile.d/
    source /etc/profile.d/$FILE

    echo "Alias updated"
}

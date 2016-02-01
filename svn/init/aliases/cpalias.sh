#!/bin/sh
# Alias that can be used to copy an alias to the /etc/profile.d/ directory
# Also sources the file so that it can be run right away
printCpaliasUsage() {
    # Print the usage message
    echo "usage: cpalias aliasfile"
    echo -e "   aliasfile:\tThe alias file to copy to /etc/profile.d/"
}

cpalias() {
    FILE=$1

    # Check the number of arguments passed in
    if [ $# -lt 1 ]; then
        echo "Error: Incorrect number of arguments"
        printCpaliasUsage
        return
    fi

    # Check if the file exists
    if [ ! -e "$FILE" ]; then
        echo "Error: File does not exist"
        printCpaliasUsage
        return
    fi

    sudo cp $FILE /etc/profile.d/
    source /etc/profile.d/$FILE

    echo "Alias updated"
}

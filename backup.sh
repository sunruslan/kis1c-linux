#!/bin/bash
counter=1
DIRECTORY="$1"
ARCHIVE="$2"
EXTENSION="$3"

if [ "$#" -gt "2" ]
then 
    rm -rf $ARCHIVE 2> /dev/null
    mkdir $ARCHIVE 2> /dev/null
    
    for ext in "$@"
    do

        if ((counter == 2))
        then 
        counter=3
        else 
        if ((counter == 1))
        then
        counter=2
        else
            find $DIRECTORY -name "*.$ext" -exec cp --parents {} $ARCHIVE/ \;
            
        fi
        fi
    done
    tar -cf $ARCHIVE.tar $ARCHIVE/ 2> /dev/null
    openssl enc -aes-256-cbc -salt -in $ARCHIVE.tar -out $ARCHIVE.tar.enc 
    # decryption openssl enc -aes-256-cbc -d $ARCHIVE.tar.enc
    rm -rf $ARCHIVE 2> /dev/null
    rm $ARCHIVE.tar 2> /dev/null
    echo "done"
else
    echo "usage: ./backup.sh <dir> <archive> <ext>"
fi

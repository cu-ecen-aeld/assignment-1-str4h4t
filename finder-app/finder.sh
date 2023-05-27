#!/bin/bash
if [ $# -eq 0 ]; then
    >&2 echo "No arguments provided"
    exit 1
fi

join_str(){
    local IFS=/
    folder="$*"
}

folder=$1
word=$2
join_str $PWD $folder
if ls $folder; then
    folder_count=$(ls $folder | wc -l)
else
    echo "folder does not exist"
    exit 1
fi

word_count=$(grep -roh --include="*" $word $folder | wc -w)
if [[ $? -ne 0 ]]; then
    echo "Cannot find folder.."
    exit 1
fi
echo "The number of files are ${folder_count} and the number of matching lines are ${word_count}"
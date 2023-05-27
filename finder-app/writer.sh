#!/bin/bash
if [ $# -eq 0 ]; then
    >&2 echo "No arguments provided"
    exit 1
fi

join_str(){
    local IFS=/
    folder_path="$*"
}

folder_path=""

writefile="$1"
writestr="$2"
readarray -d / -t files <<< "$writefile"
file_name=${files[-1]}

for (( c=1; c<=${#files[@]}-2; c++ ))
do
   join_str $folder_path ${files[c]}
#    echo $folder_path
done
mkdir -p -m777 $folder_path
if [[ $? -ne 0 ]]; then
    echo "Cannot create folder.."
    exit 1
fi
join_str $folder_path $file_name
join_str $PWD $folder_path
touch $folder_path
echo $writestr >> $folder_path
if [[ $? -ne 0 ]]; then
    echo "Cannot write to file.."
    exit 1
fi


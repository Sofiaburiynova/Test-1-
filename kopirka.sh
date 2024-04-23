#!/bin/bash

input_dir=$1
output_dir=$2

IFS=$'\n'

filesInDirectory=$(find $input_dir -type f -maxdepth 1)
directoriesinDirectory=$(find $input_dir -type d -maxdepth 1 -mindepth 1)
files=$(find $input_dir -type f)
for i in $files
do 
    filename=$(basename "$i")
    if [ -e "$output_dir/$filename" ]
    then
        new_filename="${filename%.*}_$(date +%s%N).${filename##*.}"
    else
        new_filename="$filename"
    fi
    
    cp $i $output_dir/$new_filename
done

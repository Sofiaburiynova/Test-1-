#!/bin/bash

input_dir=$1
output_dir=$2

IFS=$'\n'

filesInDirectory=$(find $input_dir -type f -maxdepth 1)
directoriesinDirectory=$(find $input_dir -type d -maxdepth 1 -mindepth 1)
files=$(find $input_dir -type f)
for i in $files
do 
    cp $i $output_dir
done

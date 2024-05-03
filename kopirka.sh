#!/bin/bash

##проверка на то, что было переданно 2 аргументва
if [ "$#" -ne 2 ]; then
    echo "Использование: $0 <входная_директория> <выходная_директория>"
    exit 1
fi

input_dir=$1
output_dir=$2

##проверка на существование директории 
if [ ! -d "$input_dir" ]; then
    echo "Директория $input_dir не имеет прав на выполнение."
    exit 1
fi

IFS=$'\n'
##c помощью команды find скрипт ищет файлы и директории во входной директории.
filesInDirectory=$(find $input_dir -type f -maxdepth 1)
##проверка на скрытность файлов
filesInDirectory=$(find $input_dir -type f -maxdepth 1 -not -name '.*')   
##Переменные filesInDirectory и directoriesinDirectory содержат список файлов и директорий соответственно.
directoriesinDirectory=$(find $input_dir -type d -maxdepth 1 -mindepth 1)
files=$(find $input_dir -type f)



##скрипт рекурсивно ободит файлы, это нужно для того, что если встретилась директория, то скрипт будет рекурсивно запущен. 
##если файлы имеют одинаковое название, то скрипт добавит число прерд названием файла 
cp_rename() {
    local src_dir="$1"
    local dest_dir="$2"
    local files=("$src_dir"/*)

    for file in "${files[@]}"; do
        if [ -d "$file" ]; then
            cp_rename "$file" "$dest_dir"
        elif [ -f "$file" ]; then
            filename=$(basename -- "$file")
            dest_file="$dest_dir/${filename}"

            if [ -f "$dest_file" ]; then
                i=1
                while [ -f "$dest_dir/($i) ${filename}" ]; do
                    ((i++))
                done
                cp "$file" "$dest_dir/($i) ${filename} "
            else
                cp "$file" "$dest_file"
            fi
        fi
    done
}

cp_rename "$input_dir" "$output_dir"


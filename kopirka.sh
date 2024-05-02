#!/bin/bash

##  Сначала скрипт проверяет, что количество переданных аргументов равно 2
if [[ $# -ne 2 ]]; then
    echo "Использование: $0 <входная_директория> <выходная_директория>"
    exit 1
fi

input_dir=$1
output_dir=$2

##проверка прав доступа 
    if [[ ! -x "$input_dir" ]]; then
        echo "Директория $input_dir не имеет прав на выполнение."
        exit 1
    fi
      

IFS=$'\n'
##С помощью команды find скрипт ищет файлы и директории во входной директории
filesInDirectory=$(find $input_dir -type f -maxdepth 1)
##проверка на скрытность файлов
filesInDirectory=$(find $input_dir -type f -maxdepth 1 -not -name '.*')   
##Переменные filesInDirectory и directoriesinDirectory содержат список файлов и директорий
directoriesinDirectory=$(find $input_dir -type d -maxdepth 1 -mindepth 1)
files=$(find $input_dir -type f)



##Для каждого файла во входной директории:Получается имя файла с помощью basename
        ##Проверяется, существует ли файл с таким же именем в выходной директории
        ##Если файл существует, создается новое имя файла, добавляя текущее время в миллисекундах к базовому имени файла
        ##Иначе используется базовое имя файла
        ##Файл копируется в выходную директорию с новым именем

for i in $files
do 
    filename=$(basename "$i")
    if [[ -e "$output_dir/$filename" ]]
    then
        new_filename="${filename%.*}_$(date +%s%N).${filename##*.}"
    else
        new_filename="$filename"
    fi
    
    cp $i $output_dir/$new_filename
done
##Скрипт завершает выполнение

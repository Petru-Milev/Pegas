#!/bin/bash 

input_files="/home/nanoen14/electric_field/files"

for file in $(ls $input_files); do 

cp "${input_files}/${file}" . 
sub-gaussian-2016-C.01 "${file}" -c 4 -m 4 -t 24

done 

#!/bin/bash 

input_files="/home/nanoen14/electric_field/files"
work_dir="/home/nanoen14/scripts/input_geometries"

for dir in $(ls $work_dir); do
for dir_1 in $(ls ${work_dir}/${dir}); do 


cd "${work_dir}/${dir}/${dir_1}"
pwd

for file in $(ls $input_files); do

cp "${input_files}/${file}" "${work_dir}/${dir}/${dir_1}"
sub-gaussian-2016-C.01 "${file}" -c 4 -m 4 -t 24

done
done
done

#!/bin/bash 

for file in $(ls 1_*); do 
awk '/SCF/ {count++; if(count==2) print $5}' $file >> eng.txt; 
echo "${file:2:-4}" >> field.txt; 
done;
paste -d "," field.txt eng.txt > miu_x.csv

rm field.txt eng.txt

for file in $(ls 2_*); do
awk '/SCF/ {count++; if(count==2) print $5}' $file >> eng.txt;
echo "${file:2:-4}" >> field.txt;
done;
paste -d "," field.txt eng.txt > miu_y.csv

rm field.txt eng.txt

for file in $(ls 3_*); do
awk '/SCF/ {count++; if(count==2) print $5}' $file >> eng.txt;
echo "${file:2:-4}" >> field.txt;
done;
paste -d "," field.txt eng.txt > miu_z.csv

rm field.txt eng.txt 

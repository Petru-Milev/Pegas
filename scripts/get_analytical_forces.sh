#!/bin/basg 


#From the output file for the energy calc. for the file with no displacements and no electric field applied
#Get a csv file with analytical_forces 

file=$1

nr_atoms=$(ls -d ${HOME}/pegas/input_geometries/* | wc -l)
line_number=$(grep -n -m 1 "Forces" $file | awk '{print $1}' | sed 's/.$//')
line_number=$(echo  "${nr_atoms} + ${line_number} + 2 " | bc)

head -n $line_number $file | tail -n $nr_atoms | awk '{print $3}' > x.txt
head -n $line_number $file | tail -n $nr_atoms | awk '{print $4}' > y.txt
head -n $line_number $file | tail -n $nr_atoms | awk '{print $5}' > z.txt

paste -d "," x.txt y.txt z.txt > analytical_forces.csv

cp analytical_forces_TRUE.csv $HOME/pegas/input_geometries

rm x.txt y.txt z.txt 


#!/bin/bash 

path_to_old_geom=$1
path_to_new_geom=$2

cp $path_to_old_geom $HOME/pegas/input_geometries/not_opt_geom.txt
cp $path_to_new_geom $HOME/pegas/input_geometries/opt_geom_coord.txt 
cd $HOME/pegas/input_geometries
awk '{print $1}' not_opt_geom.txt > atoms_column.txt
awk '{print $1}' opt_geom_coord.txt > column2.txt
awk '{print $2}' opt_geom_coord.txt > column3.txt 
awk '{print $3}' opt_geom_coord.txt > column4.txt 

paste -d ' ' atoms_column.txt column2.txt column3.txt column4.txt > new_opt_geom.txt
cp new_opt_geom.txt $path_to_old_geom
rm atoms_column.txt column2.txt column3.txt column4.txt

#!/bin/bash 

#Calculate the second derivative of Energy with respect to Field
#aka Calculate components of polarizability. In this case only xx, yy, zz components
#This scrips loops over all atoms, all displacements and from the miu_x, miu_y, miu_z csv files calculates the value for alpha_xx, alpha_yy, alpha_zz 

path=$1 

cd $path 

for atom in $(ls -d */); do 
cd $atom 
for displacement in $(ls -d */); do 
cd ${displacement}log 
fz=$(awk '/SCF/ {count++; if(count==2) print $5}' 0_0.log)
python $HOME/pegas/python_dir/RR_double_csv.py miu_x.csv $fz 
python $HOME/pegas/python_dir/RR_double_csv.py miu_y.csv $fz 
python $HOME/pegas/python_dir/RR_double_csv.py miu_z.csv $fz 
cd ../..
done 
cd ..
done 

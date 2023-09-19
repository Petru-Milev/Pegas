#!/bin/bash 

#For all atoms, get all values of dmiu_i/dx, dmiu_i/dy, dmiu_i/dz in one single file (3 files in total for miux miuy miuz)

path=$1

cd $path 
touch miu_x_for_all_atoms_column.txt 
touch miu_y_for_all_atoms_column.txt 
touch miu_z_for_all_atoms_column.txt 

for atom in $(ls -d */ | sort -h); do 
cd $atom 

echo "Getting dmiu_i/dx, dmiu_i/dy, dmiu_i/dz for x, y, z for atom $atom"

cat x_miu_x.txt >> ../miu_x_for_all_atoms_column.txt
cat y_miu_x.txt >> ../miu_x_for_all_atoms_column.txt
cat z_miu_x.txt >> ../miu_x_for_all_atoms_column.txt

cat x_miu_y.txt >> ../miu_y_for_all_atoms_column.txt
cat y_miu_y.txt >> ../miu_y_for_all_atoms_column.txt
cat z_miu_y.txt >> ../miu_y_for_all_atoms_column.txt

cat x_miu_z.txt >> ../miu_z_for_all_atoms_column.txt
cat y_miu_z.txt >> ../miu_z_for_all_atoms_column.txt
cat z_miu_z.txt >> ../miu_z_for_all_atoms_column.txt

cd .. 
done 

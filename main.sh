#!/bin/bash
geometry_path=$1 
name=$2
soft_dir="$HOME/pegas"

cd $soft_dir

echo "Making the displaced geometry"; echo; echo 

bash ./make_geom.sh $geometry_path 								#Running script that makes displacements in geometry 

echo "Submitting Geometries to Gaussian"

sbatch run_gaussian.job "${soft_dir}/input_geometries/" > out.txt				#Submitting Jobs to Gaussian 

ID=$(awk '{print $4}' out.txt)									#Saves the id of the submitted job in a variable 
echo "Job id is $ID"										#Printing id of the submitted job
echo 
echo "Checking job list"							
squeue --long --me |awk -v var=$ID '$0 ~ var {print $1}'

while [ $(squeue --long --me |awk -v var=$ID '$0 ~ var {print $1}') -eq $ID ]			#Make a while loop, to wait untill gaussian calculated all the jobs 
do												
echo "Gaussian is Working"			
squeue --long --me 
sleep 60											#Can be adjusted
done 

cd $soft_dir											#For safety 

echo "Organizing output files" 

bash ./scripts/organize_data_after_calcul.sh "${soft_dir}/input_geometries" 			#Putting all gif, log, slurm files in separate folder 

echo "Computing derivatives of energy with respect to the applied field" 			#Computing Energy with respect to applied Field = dipole moment. Derivative RR procedure

bash ./scripts/get_data_RR_eng_df.sh "${soft_dir}/input_geometries" 				#For each displacement getting a miu_x, miu_y, miu_z. 

echo "Computin second derivatives of energy with respect to electric field"

bash ${soft_dir}/scripts/calc_RR_d2E_div_dF2.sh "${soft_dir}/input_geometries"
												
echo "Computing derivatives of dipole moment with respect to the position of atoms"		#For each of the x,y,z displacements getting csv file with displacement and the corresponding miu_i 	
												#Then a python script is used to get the value of derivative of dipole moment with respect to x, y and z
bash ./scripts/get_data_RR_miu_dr.sh "${soft_dir}/input_geometries"

echo "Computing energy of zero field"								

bash ./scripts/get_energy_zero_field.sh "${soft_dir}/input_geometries"				#Generate the csv files for calculating dE/dx, dE/dy, dE/dz, at zero external field
bash ./scripts/calc_RR_energy_zero_field.sh "${soft_dir}/input_geometries"			#Python script to calculate the dE/dx ..., using RR. Also creates a matrix with dE/dx. !!! mention units

mkdir results											#Making folder with results 
mkdir results/$name
mv -r ./input_geometries/* ./results/$name/

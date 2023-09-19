#!/bin/bash
#SBATCH -p normal
#SBATCH -N 1
#SBATCH -c 3
#SBATCH --mem=10GB
#SBATCH -t 30:00:00
#SBATCH --export=none

module load gaussian/16.C.01 ; echo 
module load SciPy-bundle/2022.05-intel-2022a ; echo; echo 

geometry_path=$1 
name=$2
soft_dir="$HOME/pegas"
cpus=2
mem=7
nratoms=$(wc -l ${geometry_path} | awk '{print $1}' )

echo "Cpus used for the calculation $cpus"
echo "Memory allocated for the calculation ${mem}GB"
#----------------------------------------------------------------------
echo "Creating test files"
echo "Running gen_test.sh"; echo ; echo                                                        #Passing to the input file the number of cores and memory

cd ${soft_dir}/electric_field
bash gen_test.sh $cpus $mem ${geometry_path}

#---------------------------------------------------------------------
echo "Performing geometry optimization"; echo; echo 

cd ${soft_dir}/input_geometries

echo "g16 opt_calc.gif"; echo; echo 

g16 opt_calc.gif										#Optimizing the geometry of the input file 
#---------------------------------------------------------------------
echo "Updating the geometry with the optimised geomtry"

cd ${soft_dir}/input_geometries

bash ${soft_dir}/scripts/get_opt_geom.sh opt_calc.log $nratoms 					#Running a script that would generate a .txt file with coordinates with optimized geometries 
bash ${soft_dir}/scripts/update_geom.sh ${soft_dir}/${geometry_path} opt_geom.txt				#Saving old and new geom. Also changing the input for this script with optimized geom

#---------------------------------------------------------------------
echo; echo
echo "Making the displaced geometry"
echo "Running make_geom.sh"; echo; echo 

cd ${soft_dir}

bash ./make_geom.sh $geometry_path 								#Running script that makes displacements in geometry 
nratoms=$(ls -d ${soft_dir}/input_geometries/*/ | wc -l)
echo "Number of atoms in the input geometry is $nratoms"; echo; echo 

echo "Submitting Geometries to Gaussian" ; echo; echo
#------------------------------------------------------------------------

input_files="$HOME/pegas/electric_field/files"
work_dir="${soft_dir}/input_geometries"

echo "Start of Gaussian Calculations"
echo $(date)

echo "List of folders in $work_dir"
ls -d  $work_dir/*/ | xargs -n 1 basename

for atom in $(ls -d  $work_dir/*/ | xargs -n 1 basename); do
for displacement in $(ls ${work_dir}/${atom}); do


cd "${work_dir}/${atom}/${displacement}"
pwd

for file in $(ls $input_files); do

cp "${input_files}/${file}" "${work_dir}/${atom}/${displacement}"

#Add here a check if the file is computed to be able to resubmit the job

g16 "${file}"

done
done
done

echo "End of Gaussian calculations"
echo $(date)
#-------------------------------------------------------------------------
cd $soft_dir											#For safety 

echo "Organizing output files" ; echo 

bash ./scripts/organize_data_after_calcul.sh "${soft_dir}/input_geometries" 			#Putting all gif, log, slurm files in separate folder 

echo "Computing derivatives of energy with respect to the applied field" ; echo; echo 		#Computing Energy with respect to applied Field = dipole moment. Derivative RR procedure
echo "Running ./scripts/get_data_RR_eng_df.sh"; echo; echo; 
bash ./scripts/get_data_RR_eng_df.sh "${soft_dir}/input_geometries" 				#For each displacement getting a miu_x, miu_y, miu_z. 
												
echo "Computing derivatives of dipole moment with respect to the position of atoms"		#For each of the x,y,z displacements getting csv file with displacement and the corresponding miu_i 	
echo "Running ./scripts/get_data_RR_miu_dr.sh"; echo; echo					#Then a python script is used to get the value of derivative of dipole moment with respect to x, y and z
bash ./scripts/get_data_RR_miu_dr.sh "${soft_dir}/input_geometries"

echo "Computing energy of zero field"
echo "Running bash ./scripts/get_energy_zero_field.sh"	
echo "Running ./scripts/calc_RR_energy_zero_field.sh" ; echo; echo 						

bash ./scripts/get_energy_zero_field.sh "${soft_dir}/input_geometries"				#Generate the csv files for calculating dE/dx, dE/dy, dE/dz, at zero external field
bash ./scripts/calc_RR_energy_zero_field.sh "${soft_dir}/input_geometries"			#Python script to calculate the dE/dx ..., using RR. Also creates a matrix with dE/dx. !!! mention units
#------------------------------------------------------------------------------------------------------
echo "Creating input file for frequency calculation"

cd ${soft_dir}
bash  ${soft_dir}/electric_field/get_freq_file.sh $cpus $mem ${soft_dir}/${geometry_path}

echo "Doing the frequency calculation"
cd ${soft_dir}/input_geometries

g16 freq_calc.gif 
formchk freq_calc.chk freq_calc.fchk 
#------------------------------------------------------------------------------------------------------
echo "Getting the displacements corresponding to the vibrational modes"

bash ${soft_dir}/scripts/get_vibr_modes.sh ${soft_dir}/input_geometries $nratoms

echo "Getting values of dmiu_i/dx, dmiu_i/dy, dmiu_i/dz, for (i=x, y, z), in one single column"
echo "This will be used to get dmiu_i/dQ" ; echo ; echo 

bash ${soft_dir}/scripts/get_miu_for_nm_calc.sh "${soft_dir}/input_geometries" 			#This will create 3 files in the folder with the atoms, each file having the corresponding column
cd ${soft_dir}/input_geometries

echo "Getting numerical IR intensites du/dQ"; echo; echo; 
python ${soft_dir}/python_dir/calc_du_dQ.py $nratoms

bash ${soft_dir}/scripts/organize_after_get_ir_spectra.sh ${soft_dir}/input_geometries

#------------------------------------------------------------------------------------------------------

cd ${soft_dir}

mkdir results											#Making folder with results 
mkdir results/$name
mv  ${soft_dir}/input_geometries/* ${soft_dir}/results/$name/

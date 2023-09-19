#!/bin/bash 

path=$1

cd $path 

mkdir normal_modes
mv *_nm_miu_* normal_modes/

mkdir gaussian_calc_files
mv freq_calc* gaussian_calc_files/
mv opt_calc* gaussian_calc_files/

mkdir other 
mv vibrational_E2.txt vibrational_modes.txt miu_x_for_all_atoms_column.txt miu_y_for_all_atoms_column.txt miu_z_for_all_atoms_column.txt ./other/
mv numerical_forces* analytical_forces_matrix* ./other/

mkdir geom 
mv opt_geom.txt new_opt_geom.txt not_opt_geom.txt opt_geom_coord.txt ./geom/.

paste -d "," frequencies.txt IR_gaussian.txt > IR_gaussian.csv
paste -d "," frequencies.txt IR_numerical.txt > IR_numerical.csv
paste -d "," frequencies.txt IR_numerical.txt IR_gaussian.txt diff.txt > comparison.csv

echo -e "Freq(cm-1)\tIR_numerical\tIR_gaussian\tDiff" | column -s $'\t' -t > comparison.tab
paste -d "\t" frequencies.txt IR_gaussian.txt | column -s $'\t' -t > IR_gaussian.tab
paste -d "\t" frequencies.txt IR_numerical.txt | column -s $'\t' -t  > IR_numerical.tab
paste frequencies.txt IR_numerical.txt IR_gaussian.txt diff.txt | column -s $'\t' -t >> comparison.tab

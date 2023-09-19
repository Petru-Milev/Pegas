import numpy as np 
import sys 

def du_dQ(arr, n_mode):
	dux_dQ = np.float64(np.dot(miux, arr) * (1/(reduced_masses[n_mode-1]**0.5)))              #Calculating dmiu_x/dQ
	duy_dQ = np.float64(np.dot(miuy, arr) * (1/(reduced_masses[n_mode-1]**0.5)))		#Calculating dmiu_y/dQ
	duz_dQ = np.float64(np.dot(miuz, arr) * (1/(reduced_masses[n_mode-1]**0.5)))		#Calculating dmiu_z/dQ
	
	IR_intens = dux_dQ ** 2 + duy_dQ ** 2 + duz_dQ ** 2         				#Calculating the IR intensity 
	IR_intens = IR_intens * 2.541766 **2 * 42.256               				#Converting the IR from atomis units into km/mol
	normal_modes_intensities.append(IR_intens)						#Appending IR intensities into a vector to be printed

	to_save_dux = open(str(n_mode) + "_nm_miu_x.txt", "w")					#Saving each miu_x, miu_y, miu_z / dQ values.
	to_save_dux.write(str(dux_dQ) + "\n")
	to_save_dux.close()
	
	to_save_duy = open(str(n_mode) + "_nm_miu_y.txt", "w")
	to_save_duy.write(str(duy_dQ) + "\n")
	to_save_duy.close()
	
	to_save_duz = open(str(n_mode) +  "_nm_miu_z.txt", "w")
	to_save_duz.write(str(duz_dQ) + "\n")
	to_save_duz.close()

natm = int(sys.argv[1])										#Reading number of atoms 
nmodes = (natm * 3 - 6)										#Calculating the number of normal modes

data=np.genfromtxt("vibrational_modes.txt", delimiter = ",")					#Importing vibrational modes extracted from fchk file 
column = data.reshape(-1, 1) 									#Making a column with values of normal modes 
miux = np.genfromtxt("miu_x_for_all_atoms_column.txt")						#Getting the miux/dx, miux/dy, miux/dz values for all atoms 
miuy = np.genfromtxt("miu_y_for_all_atoms_column.txt")						#Getting the miuy/dx, miuy/dy, miuy/dz values for all atoms
miuz = np.genfromtxt("miu_z_for_all_atoms_column.txt")						#Getting the miuz/dx, miuz/dy, miuz/dz values for all atoms

column = [x for x in column[:(nmodes*natm*3)]]							#For each mode we have natm vibrating in 3 directions
vib_modes_sub_arrays = np.array_split(column, nmodes) 
#-----------------------------------------------------------------------------------------------------------------------------------
vib_E2 = np.genfromtxt('vibrational_E2.txt', delimiter=",") 					#Reading the file containing the vib_E2 matrix from the fchk file 
vib_E2 = vib_E2.reshape(1, -1)									#Reshaping the matrix into a row vector 
vib_E2_subarr = [vib_E2[0][i:i+nmodes] for i in range(0, len(vib_E2[0]), nmodes)]		#Dividing this row vector into smaller vector of length eq to nmode
frequencies = vib_E2_subarr[0]									#Assigning each subvector to its physical meaning 
reduced_masses = vib_E2_subarr[1]
frc_constants = vib_E2_subarr[2]
IR_intens = vib_E2_subarr[3]
#----------------------------------------------------------------------------------------------------------------


normal_modes_intensities = []									#Vector to save IR intensities to each vibrational mode 

i=0
for arr in vib_modes_sub_arrays:                            					#Getting IR intensities  
        i+=1
        du_dQ(arr, i)

IR_intens = np.round(IR_intens, 5)
normal_modes_intensities = np.round(normal_modes_intensities, 5)

diff = IR_intens - normal_modes_intensities
diff = np.round(diff, 5)

to_save_freq = open("frequencies.txt", "w")							#Saving the data in columns to be later manipulated with bash 
to_save_ir_gauss = open("IR_gaussian.txt", "w")
to_save_ir_numerical = open("IR_numerical.txt", "w")
to_save_diff = open("diff.txt", "w")
for i in range(len(frequencies)):								#For each iteration of the scrips, one value is saved in each of files
    to_save_freq.write(str(frequencies[i]) + "\n")
    to_save_ir_gauss.write(str(IR_intens[i]) + "\n")
    to_save_ir_numerical.write(str(normal_modes_intensities[i]) + "\n")
    to_save_diff.write(str(diff[i]) + "\n")
to_save_freq.close()
to_save_ir_gauss.close()
to_save_ir_numerical.close()
to_save_diff.close()

#Given as imputs two matrices with forces computed analiticaly (by Gaussian), and numerically by this program
#Creates a matrix that shows the differences between two forces in cal/mol 

import numpy as np 
import sys 

name_analytical = sys.argv[1]
name_numerical = sys.argv[2] 
path_to_save = sys.argv[3]

analytical = np.genfromtxt(name_analytical, delimiter=',')
numerical = -np.genfromtxt(name_numerical, delimiter=',')

result = (numerical - analytical * 1/0.529177249) * 627.5 * 1000        	#IF possible, it would be nice to avoid using a division here, but rather do a multiplication 

np.savetxt(path_to_save + '/forces_error.txt', result, fmt='%f')



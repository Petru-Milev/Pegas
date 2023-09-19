#Calculated double derivative RR method from an input of csv file and f(0)

import numpy as np 
import sys 

def RR_double(fp, fm, fz, xp, xm):
    return (fp + fm - 2*fz)/(((xp-xm)/2)**2)

filename = sys.argv[1]
fz = sys.argv[2]

fz = float(fz)

data = np.loadtxt(filename, delimiter = ',')
df = data.T

p_max = len(df[0])/2 - 1 

p_p_k = RR_double(df[1][0], df[1][p_max+1], fz, df[0][0], df[0][p_max+1])

for k in range(1, p_max+1):
        p_p_k = (4**k * p_p_k - RR_double(df[1][k], df[1][k+p_max+1], fz, df[0][k], df[0][k+p_max+1]) )/(4**k - 1)
result = float(p_p_k)

to_save = open("alpha_"+filename[4:-4] + ".txt", "w")
to_save.write(str(result) + "\n")
to_save.close()

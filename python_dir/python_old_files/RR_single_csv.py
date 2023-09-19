import numpy as np 
import sys 

def RR(fp, fm, xp, xm):
	return (fp - fm)/(xp-xm)

filename = sys.argv[1]

data = np.loadtxt(filename, delimiter = ',')
df = data.T 
p_max = round(len(df[0])/2 - 1)

p_p_k = RR(df[1][0], df[1][p_max+1], df[0][0], df[0][p_max+1])

for k in range(1, p_max+1):
	p_p_k = (4**k * p_p_k - RR(df[1][k], df[1][k+p_max+1], df[0][k], df[0][k+p_max+1]) )/(4**k - 1)
result = float(p_p_k)

to_save = open( filename[:-4] + ".txt", "w")
to_save.write(str(result) + "\n")
to_save.close()

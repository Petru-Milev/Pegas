import numpy as np

def RR(fp, fm, xp, xm):
	return (fp - fm)/(xp-xm) 
def P(p,k):
	if p == 0:
		return RR(df[1][k], df[1][k+p_max+1], df[0][k], df[0][k+p_max+1])
	else: return (4**p * P(p-1, k) - P(p-1, k+1))/(4**p - 1)

arr = ["x.csv", "y.csv", "z.csv"]

for elem in arr:
	data = np.loadtxt(elem, delimiter = ',')
	df = data.T
	p_max = round(len(df[0])/2 - 1)

	for i in range(1, 4):
		#p_p_k = RR(df[i][0], df[i][p_max+1], df[0][0], df[0][p_max+1])
		#for k in range(1, p_max+1):
			#p_p_k = (4**k * p_p_k - RR(df[i][k], df[i][k+p_max+1], df[0][k], df[0][k+p_max+1]) )/(4**k - 1)
		result = float(P(int(p_max), 0))
		if i == 1: 
			file = open(elem[:-4]+"_"+'miu_x.txt', "w")
			file.write(str(result)+"\n")
			file.close()
		elif i == 2: 
			file = open(elem[:-4]+"_"+'miu_y.txt', "w")
			file.write(str(result)+"\n")
			file.close()
		else: 
			file = open(elem[:-4]+"_"+'miu_z.txt', "w")
			file.write(str(result)+"\n")
			file.close()


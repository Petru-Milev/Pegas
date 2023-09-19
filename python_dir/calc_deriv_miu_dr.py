import numpy as np

def RR(fp, fm, xp, xm):
	return (fp - fm)/(xp-xm) 
def P(p,k,n):
	if p == 0:
		return RR(df[n][k], df[n][k+p_max+1], df[0][k], df[0][k+p_max+1])
	else: return (4**p * P(p-1, k, n) - P(p-1, k+1, n))/(4**p - 1)

arr = ["x.csv", "y.csv", "z.csv"]

for elem in arr:
	data = np.loadtxt(elem, delimiter = ',')
	df = data.T
	p_max = round(len(df[0])/2 - 1)
	p_max = int(p_max)
	for i in range(1, 4):
		#p_p_k = RR(df[i][0], df[i][p_max+1], df[0][0], df[0][p_max+1])
		#for k in range(1, p_max+1):
			#p_p_k = (4**k * p_p_k - RR(df[i][k], df[i][k+p_max+1], df[0][k], df[0][k+p_max+1]) )/(4**k - 1)
		result = float(P(int(p_max), 0, i))
		#result = float(p_p_k)
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


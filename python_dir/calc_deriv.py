import numpy as np 

def RR(fp, fm, xp, xm):
	return (fp-fm)/(xp-xm)
def P(p,k):
	if p==0:
		return RR(df[1][k], df[1][k+p_max+1], df[0][k], df[0][k+p_max+1])
	else: return (4**p * P(p-1, k) - P(p-1, k+1))/(4**p - 1)

arr = ['miu_x.csv', 'miu_y.csv', 'miu_z.csv']	


for i in arr:
	file = np.loadtxt(i, delimiter = ',')
	df = file.T
	p_max = len(df[0])/2 - 1 
	p_max = int(p_max)
	#p_p_k = RR(df[1][0], df[1][7], df[0][0], df[0][7])

	#for k in range(1, 7): 
		#p_p_k = (4**k * p_p_k - RR(df[1][k], df[1][k+7], df[0][k], df[0][k+7]) )/(4**k - 1)
	result = float(P(int(p_max), 0))
	#result = float(p_p_k)
	file = open(i[:-4]+'.txt', "w")
	file.write(str(result) + "\n")
	file.close()

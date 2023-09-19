import numpy as np 

def RR(fp, fm, xp, xm):
	return (fp-fm)/(xp-xm)

arr = ['miu_x.csv', 'miu_y.csv', 'miu_z.csv']	


for i in arr:
	file = np.loadtxt(i, delimiter = ',')
	df = file.T
	p_max = len(df[0])/2 - 1 

	p_p_k = RR(df[1][0], df[1][7], df[0][0], df[0][7])

	for k in range(1, 7): 
		p_p_k = (4**k * p_p_k - RR(df[1][k], df[1][k+7], df[0][k], df[0][k+7]) )/(4**k - 1)
	result = float(p_p_k)
	file = open(i[:-4]+'.txt', "w")
	file.write(str(result) + "\n")
	file.close()

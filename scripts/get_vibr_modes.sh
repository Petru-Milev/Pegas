#!/bin/bash 

#modify this when I have inserted the frequency calculation 

path=$1
nratoms=$2
nrvalues=$(echo "($nratoms * 3 - 6) * 3 * $nratoms" | bc)
nrline=$(echo "($nratoms * 3 - 6) * 3 * $nratoms/5" | bc)
if [ $(echo "$nrvalues % 5" | bc ) -eq 0 ]; then 
	nrline=$(echo "$nrline + 1" | bc)
	echo "1 $nrline"
else
	nrline=$(echo "$nrline + 2" | bc)
	echo "2 $nrline"
fi
echo "Nrline is $nrline"
cd $path 

awk -v var=$nrline '/Vib-Modes/ {for (i=1; i<var; i++) {getline; print}}' "freq_calc.fchk"  > tmp.txt 
awk -v OFS=',' '{print $1, $2, $3, $4, $5}' tmp.txt > vibrational_modes.txt
rm tmp.txt

nrline=$(echo "(($nratoms * 3 - 6) * 4)/5 + 1 + 1" | bc )
awk -v var=$nrline '/Vib-E2/ {for (i=1; i<var; i++) {getline; print}}' "freq_calc.fchk"  > tmp.txt
awk -v OFS=',' '{print $1, $2, $3, $4, $5}' tmp.txt > vibrational_E2.txt
rm tmp.txt

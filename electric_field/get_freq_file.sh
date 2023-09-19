#!/bin/bash 

procs=$1
mem=$2
geometry_path=$3

cd $HOME/pegas/electric_field

echo "%NprocShared=${procs}" > $HOME/pegas/electric_field/tmp
echo "%Mem=${mem}GB" >> $HOME/pegas/electric_field/tmp
cat $HOME/pegas/electric_field/freq_calc.gif >> $HOME/pegas/electric_field/tmp
cat ${geometry_path} >> $HOME/pegas/electric_field/tmp
echo >> $HOME/pegas/electric_field/tmp
echo "0.0000 0.0000 0.0000" >> $HOME/pegas/electric_field/tmp
echo >> $HOME/pegas/electric_field/tmp
echo >> $HOME/pegas/electric_field/tmp

mv $HOME/pegas/electric_field/tmp $HOME/pegas/input_geometries/freq_calc.gif
rm tmp 

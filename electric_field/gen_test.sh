#!/bin/bash 

#Change the{geometry path} here with its basename

procs=$1
mem=$2
geometry_path=$3


echo "Creating input files with the displacements of electric field"
cd  $HOME/pegas/electric_field/variations/store/

for file in $(ls); do 
echo "%NprocShared=${procs}" > $HOME/pegas/electric_field/tmp
echo "%Mem=${mem}GB" >> $HOME/pegas/electric_field/tmp
cat $HOME/pegas/electric_field/test_file.gif >> $HOME/pegas/electric_field/tmp
cat $file >> $HOME/pegas/electric_field/tmp
echo " " >> $HOME/pegas/electric_field/tmpecho " " >> $HOME/pegas/electric_field/tmp
mv $HOME/pegas/electric_field/tmp "$HOME/pegas/electric_field/files/${file}.gif"
done 

echo "Creatiig the .gif file for the optimization of the molecule" 
echo "%NprocShared=${procs}" > $HOME/pegas/electric_field/tmp
echo "%Mem=${mem}GB" >> $HOME/pegas/electric_field/tmp
cat $HOME/pegas/electric_field/opt_calc.gif >> $HOME/pegas/electric_field/tmp
cat $HOME/pegas/${geometry_path} >> $HOME/pegas/electric_field/tmp 			
echo >> $HOME/pegas/electric_field/tmp
echo "0.0000 0.0000 0.0000" >> $HOME/pegas/electric_field/tmp
echo >> $HOME/pegas/electric_field/tmp
echo >> $HOME/pegas/electric_field/tmp

mv $HOME/pegas/electric_field/tmp $HOME/pegas/input_geometries/opt_calc.gif
rm tmp

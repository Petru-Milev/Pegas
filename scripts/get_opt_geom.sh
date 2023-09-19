#!/bin/bash 

file=$1
nratoms=$2
linenr=$(awk '/Optimized/ {print NR}' $file)
tail -n +${linenr} $file > tmp
secondlinenr=$(awk '/Input orientation/ {print NR}' tmp)
tail -n +${secondlinenr} tmp > tmp1
awk -v var=$nratoms 'NR>5 && FNR<=(5+var)' tmp1 > tmp
awk -F ' ' '{print $4, $5, $6}' tmp > opt_geom.txt
rm tmp tmp1 

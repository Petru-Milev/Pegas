#!/bin/bash
displacements=(0.0002 0.0004 0.0008 0.0016 0.0032 0.0064 0.0128)

line="0.0000 0.0000 0.0000"

mkdir store

echo $line > "./store/0_0"


for displacement in "${displacements[@]}"; do
for i in {1..3}; do
touch tmp
echo $line > tmp 
awk -v iter=$i -v disp=$displacement '{$iter = $iter + disp; print }' tmp > "./store/${i}_+${displacement}"
echo $line > tmp 
awk -v iter=$i -v disp=$displacement '{$iter = $iter - disp; print }' tmp > "./store/${i}_-${displacement}"
done 
done 

rm tmp

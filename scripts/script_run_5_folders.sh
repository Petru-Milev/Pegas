#!/bin/bash

first=$1 
second=$2

for i in $(ls -1| tail -n $first | head -n 5); do 
cd $i
bash /home/nanoen14/scripts/submit_job_this_folder.sh
pwd
cd ..
done  

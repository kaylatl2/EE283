#!/bin/bash
#SBATCH --job-name=problem1    ## Name of the job.
#SBATCH -A CLASS-ECOEVO283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs

wget https://wfitch.bio.uci.edu/~tdlong/problem1.tar.gz
tar -xvf problem1.tar.gz
rm problem1.tar.gz

head -n10 problem1/p.txt | tail -n1 > problem1_answer.out
head -n10 problem1/f.txt | tail -n1 >> problem1_answer.out

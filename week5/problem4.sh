#!/bin/bash
#SBATCH --job-name=problem4
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1

#load modules
module load vcftools/0.1.16

#setting up variables
SourceDir="/pub/kaylatl2/EE283/week5/output"
DestDir="/pub/kaylatl2/EE283/week5/output"

#use awk to filter 012 output
awk '{

#!/bin/bash
#SBATCH --job-name=problem2
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1

#load modules
source /pub/kaylatl2/miniforge3/etc/profile.d/mamba.sh
source /pub/kaylatl2/miniforge3/etc/profile.d/conda.sh
mamba activate spades

#setting up variables
A4="/pub/kaylatl2/EE283/week4/output/A4_filtered2.fa"
A5="/pub/kaylatl2/EE283/week4/output/A5_filtered2.fa"
OutDir="/pub/kaylatl2/EE283/week4/output"
AssemblyDir="/pub/kaylatl2/EE283/week4/assembly"

#assemble reads
spades.py -o $AssemblyDir/A4_spades -s $A4 --isolate > $OutDir/A4.messages.txt
spades.py -o $AssemblyDir/A5_spades -s $A5 --isolate > $OutDir/A5.messages.txt




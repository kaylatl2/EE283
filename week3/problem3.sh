#!/bin/bash
#SBATCH --job-name=problem3
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=4

#load modules
module load bwa/0.7.17
module load samtools/1.15.1
module load picard-tools/2.27.1

#setting up variables
ref="/pub/kaylatl2/EE283/ref"

#create indices
bwa index $ref/dm6.fa
samtools faidx $ref/dm6.fa
java -jar /opt/apps/picard-tools/2.27.1/picard.jar \
   CreateSequenceDictionary R=$ref/dm6.fa O=$ref/dm6.dict


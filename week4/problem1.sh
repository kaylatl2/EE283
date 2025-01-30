#!/bin/bash
#SBATCH --job-name=problem1
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1

#load modules
module load samtools/1.15.1

#setting up variables
A4="/pub/kaylatl2/EE283/DNAseq/processed/ADL06_1.sort.bam"
A5="/pub/kaylatl2/EE283/DNAseq/processed/ADL09_1.sort.bam"
interval="chrX:1880000-2000000"
OutDir="/pub/kaylatl2/EE283/week4/output"

#index bam files
samtools index $A4
samtools index $A5

#extract READ-IDs from interested interval
samtools view -b $A4 $interval > $OutDir/A4_filtered.bam
samtools view -b $A5 $interval > $OutDir/A5_filtered.bam


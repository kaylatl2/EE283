#!/bin/bash
#SBATCH --job-name=problem3
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1

#load modules
module load vcftools/0.1.16

#setting up variables
SourceDir="/pub/kaylatl2/EE283/week5/processed"
DestDir="/pub/kaylatl2/EE283/week5/output"

#use vcftools to get genotype matrix
vcftools --gzvcf $SourceDir/all_variants_filtered.vcf.gz \
    --chr chrX --from-bp 0 --to-bp 1000000 \
    --012 --out $DestDir/problem2

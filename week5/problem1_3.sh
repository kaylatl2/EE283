#!/bin/bash
#SBATCH --job-name=problem1
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1
#SBATCH --array=1-7

#load modules
module load gatk/4.2.6.1

#setting up variables
SourceDir="/pub/kaylatl2/EE283/DNAseq/processed"
DestDir="/pub/kaylatl2/EE283/week5/processed"
ref="/pub/kaylatl2/EE283/ref/dm6.fa"

#call SNPs by chromosome
declare -a chrs=("chrX" "chrY" "chr2L" "chr2R" "chr3L" "chr3R" "chr4")
mychr=${chrs[$SLURM_ARRAY_TASK_ID - 1]}

gatk --java-options "-Xmx3g" GenotypeGVCFs \
-R $ref -V $DestDir/allsample.g.vcf.gz --intervals $mychr \
-stand-call-conf 5 -O $DestDir/result.${mychr}.vcf.gz

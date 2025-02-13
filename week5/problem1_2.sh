#!/bin/bash
#SBATCH --job-name=problem1
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1

#load modules
module load gatk/4.2.6.1

#setting up variables
SourceDir="/pub/kaylatl2/EE283/DNAseq/processed"
DestDir="/pub/kaylatl2/EE283/week5/processed"
ref="/pub/kaylatl2/EE283/ref/dm6.fa"

#merge gvcf files
gatk CombineGVCFs -R $ref $(printf -- '-V %s ' $SourceDir/*.g.vcf.gz) \
 -O $DestDir/allsample.g.vcf.gz

#!/bin/bash
#SBATCH --job-name=problem1
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1

#load modules
module load picard-tools/2.27.1

#setting up variables
SourceDir="/pub/kaylatl2/EE283/week5/processed"
DestDir="/pub/kaylatl2/EE283/week5/processed"

#merge vcf files
java -jar /opt/apps/picard-tools/2.27.1/picard.jar MergeVcfs \
$(printf 'I=%s ' $SourceDir/result.*.vcf.gz) O=$DestDir/all_variants.vcf.gz

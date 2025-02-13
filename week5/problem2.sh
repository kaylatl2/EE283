#!/bin/bash
#SBATCH --job-name=problem2
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1

#load modules
module load  bcftools/1.15.1

#setting up variables
SourceDir="/pub/kaylatl2/EE283/week5/processed"
DestDir="/pub/kaylatl2/EE283/week5/processed"
ref="/pub/kaylatl2/EE283/ref/dm6.fa"

#before filtering
zgrep -vc "^#" $SourceDir/all_variants.vcf.gz > $DestDir/problem2.txt

#filter step 1
bcftools filter -i 'FS<40.0 && SOR<3 && MQ>40.0 && MQRankSum>-5.0 && MQRankSum<5 && QD>2.0 && ReadPosRankSum>-4.0 && INFO/DP<16000' \
   -O z -o $DestDir/output1.vcf.gz $SourceDir/all_variants.vcf.gz

zgrep -vc "^#" $DestDir/output1.vcf.gz >> $DestDir/problem2.txt

#filter step 2
bcftools filter -S . -e 'FMT/DP<3 | FMT/GQ<20' -O z -o $DestDir/output2.vcf.gz $DestDir/output1.vcf.gz

zgrep -vc "^#" $DestDir/output2.vcf.gz >> $DestDir/problem2.txt
rm $DestDir/output1.vcf.gz

#filter step 3
bcftools filter -e 'AC==0 || AC==AN' --SnpGap 10 -O z $DestDir/output2.vcf.gz | \
bcftools view -m2 -M2 -v snps -O z -o $DestDir/all_variants_filtered.vcf.gz

zgrep -vc "^#" $DestDir/all_variants_filtered.vcf.gz >> $DestDir/problem2.txt
rm $DestDir/output2.vcf.gz

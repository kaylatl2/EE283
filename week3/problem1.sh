#!/bin/bash
#SBATCH --job-name=problem1
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1

#load modules
module load fastqc/0.11.9
module load trimmomatic/0.39

#setting up variables
SourceDir="/pub/kaylatl2/EE283/DNAseq/rawdata"
DestDir="/pub/kaylatl2/EE283/DNAseq/fastqc"

#fastqc alone
fastqc -o $DestDir $SourceDir/ADL06_1_1.fq.gz $SourceDir/ADL06_1_2.fq.gz

#trimmomatic then fastqc
java -jar /opt/apps/trimmomatic/0.39/trimmomatic-0.39.jar PE \
   -threads 4 \
   $SourceDir/ADL06_1_1.fq.gz $SourceDir/ADL06_1_2.fq.gz \
   $DestDir/trimmed/ADL06_1_1_paired.fastq $DestDir/trimmed/ADL06_1_1_unpaired.fastq \
   $DestDir/trimmed/ADL06_1_2_paired.fastq $DestDir/trimmed/ADL06_1_2_unpaired.fastq \
   ILLUMINACLIP:/opt/apps/trimmomatic/0.39/adapters/TruSeq3-PE.fa:2:30:10 \
   LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

fastqc -o $DestDir/trimmed $DestDir/trimmed/ADL06_1_1_paired.fastq $DestDir/trimmed/ADL06_1_2_paired.fastq


##Comparing fastqc alone to trimmomatic then fastqc (only those high-quality, paired reads),
##I noticed that the sequence length distribution is generally wider in the latter
##with less total sequences because reads have been trimmmed and filtered for quality

#!/bin/bash
#SBATCH --job-name=problem2
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1

#load modules
module load fastqc/0.11.9
module load trimmomatic/0.39

#setting up variables
SourceDir="/pub/kaylatl2/EE283/ATACseq/rawdata"
DestDir="/pub/kaylatl2/EE283/ATACseq/fastqc"

#fastqc alone
fastqc -o $DestDir $SourceDir/A4_ED_2_R1.fq.gz $SourceDir/A4_ED_2_R2.fq.gz

#trimmomatic then fastqc
java -jar /opt/apps/trimmomatic/0.39/trimmomatic-0.39.jar PE \
   -threads 4 \
   $SourceDir/A4_ED_2_R1.fq.gz $SourceDir/A4_ED_2_R2.fq.gz \
   $DestDir/trimmed/A4_ED_2_R1_paired.fastq $DestDir/trimmed/A4_ED_2_R1_unpaired.fastq \
   $DestDir/trimmed/A4_ED_2_R2_paired.fastq $DestDir/trimmed/A4_ED_2_R2_unpaired.fastq \
   ILLUMINACLIP:/opt/apps/trimmomatic/0.39/adapters/TruSeq3-PE.fa:2:30:10 \
   LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

fastqc -o $DestDir/trimmed $DestDir/trimmed/A4_ED_2_R1_paired.fastq $DestDir/trimmed/A4_ED_2_R2_paired.fastq



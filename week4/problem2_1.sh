#!/bin/bash
#SBATCH --job-name=problem2
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1

#load modules
module load samtools/1.15.1

#setting up variables
A4="/pub/kaylatl2/EE283/DNAseq/processed/ADL06_1.sort.bam"
A5="/pub/kaylatl2/EE283/DNAseq/processed/ADL09_1.sort.bam"
interval="chrX:1903800-1904200"
helpfile="/pub/kaylatl2/EE283/week4/helpfiles"
OutDir="/pub/kaylatl2/EE283/week4/output"

#extract READ-IDs from interested interval
samtools view $A4 $interval | cut -f1 > $helpfile/A4.IDs.txt
samtools view $A5 $interval | cut -f1 > $helpfile/A5.IDs.txt

#extract reads in interested interval
samtools view $A4 $interval | grep -f $helpfile/A4.IDs.txt |\
    awk '{if($3 != "X"){printf(">%s\n%s\n",$1,$10)}}' >$OutDir/A4_filtered2.fa
samtools view $A5 $interval | grep -f $helpfile/A5.IDs.txt |\
    awk '{if($3 != "X"){printf(">%s\n%s\n",$1,$10)}}' >$OutDir/A5_filtered2.fa

#count no. of IDs and no. of reads in fasta
cat $OutDir/A4_filtered2.fa | grep ">" | wc -l
cat $OutDir/A5_filtered2.fa | grep ">" | wc -l
wc -l $helpfile/A4.IDs.txt
wc -l $helpfile/A5.IDs.txt

##A4:42301 (match)
##A5:41368 (match)

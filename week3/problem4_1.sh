#!/bin/bash
#SBATCH --job-name=problem4_1
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2
#SBATCH --array=1-12

#load modules
module load bwa/0.7.17
module load samtools/1.15.1

#setting up variables
SourceDir="/pub/kaylatl2/EE283/DNAseq/rawdata"
DestDir="/pub/kaylatl2/EE283/DNAseq/processed"
ref="/pub/kaylatl2/EE283/ref/dm6.fa"
file="/pub/kaylatl2/EE283/DNAseq/rawdata/prefixes.txt"
prefix=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1`

#align DNAseq data
bwa mem -t 2 -M $ref $SourceDir/${prefix}_1.fq.gz $SourceDir/${prefix}_2.fq.gz \
   | samtools view -bS - > $DestDir/${prefix}.bam
samtools sort $DestDir/${prefix}.bam -o $DestDir/${prefix}.sort.bam
rm $DestDir/${prefix}.bam

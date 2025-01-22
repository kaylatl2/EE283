#!/bin/bash
#SBATCH --job-name=problem5
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2
#SBATCH --array=1-376

#load modules
module load hisat2/2.2.1
module load samtools/1.15.1

#setting up variables
SourceDir="/pub/kaylatl2/EE283/RNAseq/rawdata"
DestDir="/pub/kaylatl2/EE283/RNAseq/processed"
RefDir="/pub/kaylatl2/EE283/ref"
ref="/pub/kaylatl2/EE283/ref/dm6.fa"
gtf="/pub/kaylatl2/EE283/ref/dmel-all-r6.13.gtf"
file="/pub/kaylatl2/EE283/RNAseq/rawdata/prefixes.txt"
prefix=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1`

#build hisat2 index
#python hisat2_extract_splice_sites.py $gtf > $RefDir/dm6.ss
#python hisat2_extract_exons.py $gtf > $RefDir/dm6.exon
#hisat2-build -p 8 --exon $RefDir/dm6.exon --ss $RefDir/dm6.ss $ref $RefDir/dm6_trans

#align RNAseq data
hisat2 -p 2 -x $RefDir/dm6_trans -1 $SourceDir/${prefix}_R1.fq.gz -2 $SourceDir/${prefix}_R2.fq.gz \
 | samtools view -bS - > $DestDir/${prefix}.bam
samtools sort $DestDir/${prefix}.bam -o $DestDir/${prefix}.sort.bam
samtools index $DestDir/${prefix}.sort.bam
rm $DestDir/${prefix}.bam

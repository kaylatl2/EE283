#!/bin/bash
#SBATCH --job-name=problem1
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1
#SBATCH --array=1-6

#load modules
module load picard-tools/2.27.1
module load samtools/1.15.1

#setting up variables
SourceDir="/pub/kaylatl2/EE283/ATACseq/processed"
DestDir="/pub/kaylatl2/EE283/week6/processed"
file="/pub/kaylatl2/EE283/week6/helpfiles/prefixes.txt"
prefix=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1`

#index reads
samtools index $SourceDir/${prefix}.sort.bam $SourceDir/${prefix}.sort.bam.bai

#filter for chrX and high quality reads
samtools view -q 30 -b $SourceDir/${prefix}.sort.bam chrX \
	| samtools sort -O BAM - > $DestDir/${prefix}.ATAC.chrX.bam

#remove PCR duplicates (optional)
java -jar /opt/apps/picard-tools/2.27.1/picard.jar MarkDuplicates \
        I=$DestDir/${prefix}.ATAC.chrX.bam \
        O=$DestDir/${prefix}.ATAC.chrX.dedup.bam \
        M=$DestDir/${prefix}.test.marked_dup_metrics.txt \
	REMOVE_DUPLICATES=true

samtools index $DestDir/${prefix}.ATAC.chrX.dedup.bam $DestDir/${prefix}.ATAC.chrX.dedup.bam.bai

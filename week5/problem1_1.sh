#!/bin/bash
#SBATCH --job-name=problem1
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1
#SBATCH --array=1-4

#load modules
module load java/1.8.0
module load gatk/4.2.6.1
module load picard-tools/2.27.1
module load samtools/1.15.1

#setting up variables
SourceDir="/pub/kaylatl2/EE283/DNAseq/processed"
DestDir="/pub/kaylatl2/EE283/DNAseq/processed"
file="/pub/kaylatl2/EE283/DNAseq/processed/prefixes.txt"
ref="/pub/kaylatl2/EE283/ref/dm6.fa"
prefix=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1`

#merge bam files associated with same genotype (ADL01,ADL06,ADL09,ADL14)
samtools merge -o $DestDir/${prefix}.bam $(printf '%s ' $SourceDir/${prefix}*.sort.bam)
samtools sort $DestDir/${prefix}.bam -o $DestDir/${prefix}.sort.bam
rm $DestDir/${prefix}.bam

#add readgroups
java -jar /opt/apps/picard-tools/2.27.1/picard.jar AddOrReplaceReadGroups \
I=$DestDir/${prefix}.sort.bam O=$DestDir/${prefix}.RG.bam SORT_ORDER=coordinate \
RGPL=illumina RGPU=D109LACXX RGLB=Lib1 RGID=$prefix RGSM=$prefix \
VALIDATION_STRINGENCY=LENIENT
rm $DestDir/${prefix}.sort.bam

#remove PCR duplicates
java -jar /opt/apps/picard-tools/2.27.1/picard.jar MarkDuplicates REMOVE_DUPLICATES=true \
I=$DestDir/${prefix}.RG.bam O=$DestDir/${prefix}.dedup.bam M=$DestDir/${prefix}_marked_dup_metrics.txt
samtools index $DestDir/${prefix}.dedup.bam
rm $DestDir/${prefix}.RG.bam

#run haplotypecaller
/opt/apps/gatk/4.2.6.1/gatk HaplotypeCaller -R $ref -I $DestDir/${prefix}.dedup.bam \
 --minimum-mapping-quality 30 -ERC GVCF -O $DestDir/${prefix}.g.vcf.gz

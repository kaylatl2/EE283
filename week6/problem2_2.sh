#!/bin/bash
#SBATCH --job-name=problem2
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1

#load modules
module load samtools/1.15.1
module load bedtools2/2.30.0
module load macs/2.2.7.1
module load ucsc-tools/v429

#setting up variables
SourceDir="/pub/kaylatl2/EE283/week6/processed"
DestDir="/pub/kaylatl2/EE283/week6/output"
ref="/pub/kaylatl2/EE283/ref"

#merge samples (A7_WD_1)
samtools merge -o $SourceDir/A7_WD.bam $SourceDir/*.ATAC.dedup.bam

#convert to a bed file
bedtools bamtobed -i $SourceDir/A7_WD.bam \
	| awk -F $'\t' 'BEGIN {OFS = FS}{ if ($6 == "+") {$2 = $2 + 4} else if ($6 == "-") {$3 = $3 - 5} print $0}' \
	> $DestDir/A7_WD.tn5.bed

#call peaks (regions with openness)
macs2 callpeak -t $DestDir/A7_WD.tn5.bed -n $DestDir/A7_WD \
	-f BED -g dm -q 0.01 --nomodel --shift -75 --extsize 150 --keep-dup all -B --broad

#create files for chr sizes
fetchChromSizes dm6 > $ref/dm6.chrom.sizes

#create a bigwig
LC_COLLATE=C sort -k1,1 -k2,2n $DestDir/A7_WD_treat_pileup.bdg > $DestDir/A7_WD.broad_treat_pileup.sorted.bdg
awk 'NR==FNR {chr_size[$1]=$2; next} $3 < chr_size[$1] {print}' $ref/dm6.chrom.sizes $DestDir/A7_WD.broad_treat_pileup.sorted.bdg > $DestDir/A7_WD.filtered.bdg
bedGraphToBigWig $DestDir/A7_WD.filtered.bdg $ref/dm6.chrom.sizes $DestDir/A7_WD.broad_peaks.bw


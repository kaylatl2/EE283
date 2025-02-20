#!/bin/bash
#SBATCH --job-name=problem2
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1

#load modules
module load subread/2.0.3

#assign variables
OutDir="/pub/kaylatl2/EE283/week7/output"
SourceDir="/pub/kaylatl2/EE283/week7/helpfiles"
gtf="/pub/kaylatl2/EE283/ref/dmel-all-r6.13.gtf"
myfile=$(cat helpfiles/shortRNAseq.names.txt | xargs echo)

featureCounts -p -T 8 -t exon -g gene_id -Q 30 -F GTF -a $gtf -o $OutDir/fly_counts.txt $myfile

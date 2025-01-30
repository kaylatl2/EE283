#!/bin/bash
#SBATCH --job-name=problem4
#SBATCH -A class-ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=1

#load modules
source /pub/kaylatl2/miniforge3/etc/profile.d/mamba.sh
source /pub/kaylatl2/miniforge3/etc/profile.d/conda.sh
mamba activate deeptools
module load samtools/1.15.1

#setting up variables
A4="/pub/kaylatl2/EE283/week4/output/A4_filtered.bam"
A5="/pub/kaylatl2/EE283/week4/output/A5_filtered.bam"
OutDir="/pub/kaylatl2/EE283/week4/output"

#plot fragment coverage
bamCoverage -b $A4 -o $OutDir/extend_A4_coverage.bedgraph \
    --binSize 1 \
    --extendReads \
    --outFileFormat bedgraph

bamCoverage -b $A5 -o $OutDir/extend_A5_coverage.bedgraph \
    --binSize 1 \
    --extendReads \
    --outFileFormat bedgraph

name #!/bin/bash

SourceDir="/data/class/ecoevo283/public/Bioinformatics_Course/RNAseq"
DestDir="/pub/kaylatl2/EE283/RNAseq/rawdata"
File="/pub/kaylatl2/EE283/RNAseq/RNAseq.labels.txt"

find $SourceDir -type f -iname "*.gz"

while read p
do
   echo "${p}"
   samplenumber=$(echo $p | cut -f1 -d" ")
   barcode=$(echo $p | cut -f4 -d" ")
   lane=$(echo $p | cut -f3 -d" ")
   replicate=$(echo $p | cut -f11 -d" ")
   platename=$(echo $p | cut -f5 -d" ")
   platewell=$(echo $p | cut -f8 -d" ")
   fullsamplename=$(echo $p | cut -f12 -d" ")
   READ1=$(find ${SourceDir}/ -type f -iname "${samplenumber}_${barcode}_${lane}*_R1_001.fastq.gz")
   READ2=$(find ${SourceDir}/ -type f -iname "${samplenumber}_${barcode}_${lane}*_R2_001.fastq.gz")

ln -s $READ1 $DestDir/${fullsamplename}_${platename}_${platewell}_rep${replicate}_R1.fq.gz
ln -s $READ2 $DestDir/${fullsamplename}_${platename}_${platewell}_rep${replicate}_R2.fq.gz

done < $File



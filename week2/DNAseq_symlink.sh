#!/bin/bash

SourceDir="/data/class/ecoevo283/public/Bioinformatics_Course/DNAseq"
DestDir="/pub/kaylatl2/EE283/DNAseq/rawdata"
FILES="$SourceDir/*"

for f in $FILES
do
   ff=$(basename $f)
   echo "Processing $ff file..."
   ln -s $SourceDir/$ff $DestDir/$ff
done





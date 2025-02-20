library(tidyverse)

mytab = read_tsv("helpfiles/RNAseq.samcode.txt")
mytab

mytab2 <- mytab %>%
	select(RILcode, TissueCode, Replicate, FullSampleName)	
table(mytab2$RILcode)
table(mytab2$TissueCode)
table(mytab2$Replicate)

mytab2 <- mytab %>%
	select(RILcode, TissueCode, Replicate, FullSampleName) %>%
	filter(RILcode %in% c(21148, 21286, 22162, 21297, 21029, 22052, 22031, 21293, 22378, 22390)) %>%
	filter(TissueCode %in% c("B", "E")) %>%
	filter(Replicate == "0")

for(i in 1:nrow(mytab2)){
  cat("/pub/kaylatl2/EE283/RNAseq/processed/",mytab2$FullSampleName[i],"*.bam\n",file="helpfiles/shortRNAseq.names.txt",append=TRUE,sep='')
	}
write_tsv(mytab2,"helpfiles/shortRNAseq.txt")

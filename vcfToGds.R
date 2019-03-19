# Adapted from:
# 	Author: topmed analysis pipeline, smgogarten
# 	Link: https://github.com/smgogarten/analysis_pipeline/blob/master/R/vcf2gds.R

library(SeqArray)

args <- commandArgs(trailingOnly=T)
vcf <- args[1]
gds_out <- paste(args[2],".gds",sep="")
ncpu <- as.numeric(args[3])

seqVCF2GDS(vcf, gds_out, storage.option="LZMA_RA", parallel=ncpu, verbose=TRUE)

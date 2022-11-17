#summaryRprof(by.self)
#summaryRprof(filename = "Rprof.out")
#summaryRprof()
#summaryRprof(tmp <- tempfile())
Rprof(tmp <- tempfile())


library(xcms)
library(CAMERA)
library(BiocParallel)


#cores = strtoi(Sys.getenv("SLURM_NTASKS"))
#register(bpstart(MulticoreParam(cores)))
#register(bpstart(MulticoreParam(72)))


path <- "/rds/projects/2017/orsinil-zhou/For Narges/NBAF/Data/Samples/mzML/All/"
datafiles <- list.files(path, full.names=T, pattern='.mzML')


xset = NULL

if( file.exists("xset_all_peaks.RData") ) {
  xset = readRDS("xset_all_peaks.RData")
} else {   
  #xset <- xcmsSet(files = datafiles, method = "centWave", ppm=11, peakwidth=c(3,30), snthresh=10, prefilter=c(3,100), mzCenterFun="wMean", integrate=1, mzdiff=0.001, noise=1, BPPARAM=MulticoreParam())
  xset <- xcmsSet(files = datafiles, method = "centWave", ppm=20, peakwidth=c(10,60), snthresh=10, prefilter=c(3,5000), mzCenterFun="wMean", integrate=1, mzdiff=0.001, noise=1, BPPARAM=MulticoreParam())
  saveRDS(xset, file = "xset_all_peaks.RData")
  write.csv(xset@peaks, "all_peaks.csv")
  print("all_peaks.csv generated")
}



if( file.exists("xset_grouped_peaks.RData") ) {
  xset = readRDS("xset_grouped_peaks.RData")
} else {   
  xset <- group(xset, method="density", bw=5, mzwid=0.001, minfrac=0.06)
  saveRDS(xset, file = "xset_grouped_peaks.RData")
  write.csv(xset@peaks, "grouped_peaks.csv")
  print("grouped_peaks.csv generated")
}


if( file.exists("xset_retcor_peaks.RData") ) {
  xset = readRDS("xset_retcor_peaks.RData")
} else {   
  xset = readRDS("xset_grouped_peaks.RData")
  xset <- retcor(xset)
  saveRDS(xset, file = "xset_retcor_peaks.RData")
  write.csv(xset@peaks, "retcor_peaks.csv")
  print("retcor_peaks.csv generated")
}


if( file.exists("xset_regrouped_peaks.RData") ) {
  xset = readRDS("xset_regrouped_peaks.RData")
} else {   
  xset = readRDS("xset_retcor_peaks.RData")
  xset <- group(xset, bw=5, mzwid=0.001, minfrac=0.06)
  saveRDS(xset, file = "xset_regrouped_peaks.RData")
  write.csv(xset@peaks, "regrouped_peaks.csv")
  print("regrouped_peaks.csv generated")
}


if( file.exists("xset_filled_peaks.RData") ) {
  xset = readRDS("xset_filled_peaks.RData")
} else {   
  xset = readRDS("xset_regrouped_peaks.RData")
  xset <- fillPeaks(xset, method="chrom")
  saveRDS(xset, file = "xset_filled_peaks.RData")
  write.csv(xset@peaks, "filled_peaks.csv")
  print("filled_peaks.csv generated")
}


if( file.exists("xset_annotated_peaks.RData") ) {
  xset = readRDS("xset_annotated_peaks.RData")
} else {   
  xset = readRDS("xset_filled_peaks.RData")
  
  an <- xsAnnotate(xset, sample=NA)
  anF <- groupFWHM(an, perfwhm = 0.6)
  anI <- findIsotopes(anF, mzabs=0.01)
  anIC <- groupCorr(anI, cor_eic_th=0.75)
  anFA <- findAdducts(anIC, polarity="positive")
  
  saveRDS(getPeaklist(anFA), file = "xset_annotated_peaks.RData")
  write.csv(getPeaklist(anFA), file="annotated_peaks.csv")
  print("annotated_peaks.csv generated")
}



Rprof(NULL)
summaryRprof(tmp)


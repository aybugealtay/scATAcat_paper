R.version

library(DiffBind)

CorcesDataInfo =read.csv("/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/preprocessing/Corces2016_bulk_ATAC/differentially_accessible_regions/all_BM_cell_types-for_NeurIPS_BM_sc_multiome/Corces2016_with_calderon_pDC_complete_meta.csv",
                          sep = ";",stringsAsFactors=FALSE) #, header=TRUE,row.names=NULL
head(CorcesDataInfo)

tail(CorcesDataInfo)

corces_DBdata <- dba(sampleSheet=CorcesDataInfo) 

corces_DBdata

corces <- dba.count(corces_DBdata)


plot(corces,)

info <- dba.show(corces)
libsizes <- cbind(LibReads=info$Reads, FRiP=info$FRiP,PeakReads=round(info$Reads * info$FRiP))
rownames(libsizes) <- info$ID
libsizes

corces_norm <- dba.normalize(corces)

plot(corces_norm)

dba.plotPCA(corces_norm,  attributes=DBA_CONTROL, label=DBA_ID)

norm <- dba.normalize(corces_norm, bRetrieve=TRUE)
normlibs <- cbind(FullLibSize=norm$lib.sizes, NormFacs=norm$norm.factors, NormLibSize=round(norm$lib.sizes/norm$norm.factors))
rownames(normlibs) <- info$ID
normlibs

corces_norm <- dba.contrast(corces_norm, categories=DBA_CONDITION,minMembers = 2)

corces_norm

corces_norm <- dba.analyze(corces_norm, bParallel = FALSE)

saveRDS(corces_norm, file="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/preprocessing/Corces2016_bulk_ATAC/differentially_accessible_regions/all_BM_cell_types-for_NeurIPS_BM_sc_multiome/WS/corces_norm.RDS")


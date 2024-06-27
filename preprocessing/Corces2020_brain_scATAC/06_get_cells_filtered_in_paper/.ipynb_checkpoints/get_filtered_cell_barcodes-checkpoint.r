# source : https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE147672
sum_ex = readRDS("/project/scATAC_analysis/10X_scATAC_HumanBrain_Corces2020/data/GSE147672_200324_Brain_scATAC_SummarizedExperiment_forGEO.rds")
CAUD_06_0615_cells = colnames(sum_ex)[grep('CAUD_06_0615', colnames(sum_ex))]
CAUD_06_0615_cell_barcodes = lapply(CAUD_06_0615_cells,FUN=function(x) strsplit(x, "#")[[1]][2])
                                    
df <- data.frame(cellIDs = matrix(unlist(CAUD_06_0615_cell_barcodeas), byrow=TRUE),stringsAsFactors=FALSE)
write.csv2(df, "/project/scATAC_analysis/scATAcat_review/data/Corces2020_brain_scATAC/06_get_cells_filtered_in_paper/Corces2020_scATAC_filtered_cell_barcodes.csv")
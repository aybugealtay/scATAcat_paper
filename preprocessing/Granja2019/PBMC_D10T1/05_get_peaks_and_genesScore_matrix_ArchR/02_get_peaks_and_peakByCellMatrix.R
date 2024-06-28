library(ArchR)
library(Matrix)
# project_path: path to the initial ArchR project folder
project_path = '/project/scATAC_analysis/scATAcat_review/data/Granja2019/PBMC_D10T1/05_peaks_and_genesScore_matrix_ArchR/'
out_path = "/project/scATAC_analysis/scATAcat_review/data/Granja2019/PBMC_D10T1/05_peaks_and_genesScore_matrix_ArchR/input_for_EpiAnno/" # where to save resulting matrices | with / at the end
threads_=1 # how many threads to use

proj1 = loadArchRProject(path = project_path)
addArchRThreads(threads = threads_) 
addArchRGenome("hg38")
proj1 <- addIterativeLSI(
    ArchRProj = proj1,
    useMatrix = "TileMatrix", 
    name = "IterativeLSI", 
    iterations = 2, 
    clusterParams = list( #See Seurat::FindClusters
        resolution = c(0.2), 
        sampleCells = 10000, 
        n.start = 10
    ), 
    varFeatures = 25000, 
    dimsToUse = 1:30
)

proj1 <- addClusters(
    input = proj1,
    reducedDims = "IterativeLSI",
    method = "Seurat",
    name = "Clusters",
    resolution = 0.8
)

proj1 <- addUMAP(
    ArchRProj = proj1, 
    reducedDims = "IterativeLSI", 
    name = "UMAP", 
    nNeighbors = 30, 
    minDist = 0.5, 
    metric = "cosine"
)

HDF5_USE_FILE_LOCKING=FALSE
RHDF5_USE_FILE_LOCKING=FALSE

proj2 <- addGroupCoverages(ArchRProj = proj1, groupBy = "Clusters")

pathToMacs2 <- findMacs2()

proj2 <- addReproduciblePeakSet(
    ArchRProj = proj2, 
    groupBy = "Clusters", 
    pathToMacs2 = pathToMacs2
)


#saveArchRProject(ArchRProj = proj2, outputDirectory = "Save-Proj2_afterPeakCalling", load = FALSE)

proj3 <- addPeakMatrix(proj2)

peakMatrix <- getMatrixFromProject(proj3, useMatrix='PeakMatrix')

PeakMatrix_proj3_dense =  as.matrix(peakMatrix@assays@data@listData$PeakMatrix)

write.csv(PeakMatrix_proj3_dense, file = paste(out_path,"PeakMatrix_dense.csv",sep="" )) 

# get the peak regions
proj3_peak_metadata  = (getPeakSet(proj3))
proj3_peak_regions = data.frame(seqnames = seqnames(proj3_peak_metadata),
           start= start(proj3_peak_metadata),
            end = end(proj3_peak_metadata))

write.csv(proj3_peak_metadata, file =paste(out_path,"peak_metadata.csv",sep="" ))
write.csv(proj3_peak_regions, file =paste(out_path,"peak_regions.csv",sep="" ))
write.table(proj3_peak_regions, file =paste(out_path,"peak_regions.tsv",sep="" ),col.names = F,row.names=FALSE,sep="\t", quote = FALSE)

# save the peak matrix as sparse mtx


# save sparse matrix
sparse_matrix <- Matrix(PeakMatrix_proj3_dense , sparse = T )
writeMM(obj = sparse_matrix, file = paste(out_path,"ArchR_peakMatrix.mtx",sep="" ))

# save genes and cells names
combined_peak_features =  paste(proj3_peak_regions$seqnames,"_",proj3_peak_regions$start,"_",proj3_peak_regions$end, sep="")

write.table(as.data.frame(combined_peak_features), file = paste(out_path,"ArchR_peaks.tsv",sep="" ) , row.names = FALSE, quote = FALSE, col.names = FALSE)

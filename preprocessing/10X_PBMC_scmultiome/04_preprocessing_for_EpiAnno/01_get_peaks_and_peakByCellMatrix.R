library(ArchR)
# project_path: path to the initial ArchR project folder
project_path = '/project/scATAC_analysis/scATAcat_review/benchmarking/Cellcano/apply_PBMC/test_data_PBMC_10x_scmultiome/'
out_path = "/project/scATAC_analysis/scATAcat_review/data/10X_PBMC_scmultiome/04_input_for_EpiAnno/" # where to save resulting matrices | with / at the end
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


saveArchRProject(ArchRProj = proj2, outputDirectory = "Save-Proj2_afterPeakCalling", load = FALSE)

proj3 <- addPeakMatrix(proj2)

peakMatrix <- getMatrixFromProject(proj3, useMatrix='PeakMatrix')

PeakMatrix_proj3_dense =  as.matrix(proj3@assays@data@listData$PeakMatrix)

write.csv(PeakMatrix_proj3_dense, file = paste(out_path,"PeakMatrix_dense.csv",sep="" )) 

# get the peak regions
proj3_peak_metadata  = (getPeakSet(proj3))
proj3_peak_regions = data.frame(seqnames = seqnames(proj3_peak_metadata),
           start= start(proj3_peak_metadata),
            end = end(proj3_peak_metadata))

write.csv(proj3_peak_metadata, file =paste(out_path,"peak_metadata.csv",sep="" ))
write.csv(proj3_peak_regions, file =paste(out_path,"proj3_peak_regions.csv",sep="" ))
write.table(PBMC_10X_proj3_peak_metadata_peak_regions, paste(out_path,"PBMC_10X_proj3_peak_regions.tsv",sep="" ),col.names = F,row.names=FALSE,sep="\t", quote = FALSE)                      
                         

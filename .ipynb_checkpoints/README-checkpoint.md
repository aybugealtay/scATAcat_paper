[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.10532547.svg)](https://doi.org/10.5281/zenodo.10532547)

### Code reproducing the figures in the scATAcat manuscript

The provided code reproduces the figures presented in the manuscript. To enhance accessibility, the code and notebooks are organized into the following structure:

- **Preprocessing**
    - Obtaining ENCODE cCRE coverages of all the datasets
    - Doublet detection for single-cell (PBMC) dataset
    - Generating synthetic bulk dataset for fesibility study
    - Differential accesibility analysis for the prototype bulk ATAC-seq samples

    Outputs of the preprocessing steps are stored in the `Data` folder.
  
- **Notebooks**
    - Notebooks to reproduce figures in the manuscript
    -  For each dataset, notebooks include scripts to apply:
        - scATAcat
        - Marker-based annotation
        - Seurat label-transfer
        - Cellcano
        - EpiAnno
    - Notebooks reproducing Supplementary tables
  
  Outputs of the notebooks are stored in the `Results` folder. All the files that are exceeding the github file limit are located in the Zenodo repo
        
- **Results**
    - Figures and output files resulting from the notebook runs
   
- **Data**
    - Placeholder for the data folder. The content of data folder can be access from Zenado:
 
All the files that are exceeding the github file limit are also located in the same zenado repo:
 

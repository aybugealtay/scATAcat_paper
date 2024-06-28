conda activate Cellcano
cd /project/scATAC_analysis/scATAcat_review/data/Granja2019/PBMC_D10T1/05_peaks_and_genesScore_matrix_ArchR/

Cellcano preprocess -i /project/scATAC_analysis/scATAcat_review/data/Granja2019/PBMC_D10T1/01_prepare_fragments_file/final_fragment_files/ -o /project/scATAC_analysis/scATAcat_review/data/Granja2019/PBMC_D10T1/05_peaks_and_genesScore_matrix_ArchR/ -g hg38 --threads 10


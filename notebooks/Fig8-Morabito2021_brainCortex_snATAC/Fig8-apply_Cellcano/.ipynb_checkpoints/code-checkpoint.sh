# test
conda activate Cellcano5
Cellcano predict -i /project/scATAC_analysis/scATAcat_review/data/Granja2019/PBMC_D10T1/05_peaks_and_genesScore_matrix_ArchR/ArchR_genescore \
	--trained_model /project/scATAC_analysis/scATAcat_review/data/Satpathy2019/PBMC_Rep1_scATAC/04_preprocessing_for_Cellcano/output/GSM3722015_PBMC_Rep1_trainedMLP_model \
	-o /project/scATAC_analysis/scATAcat_review/results/Fig6-Granja_PBMC_scATAC/Fig6-apply_Cellcano/output_Celcano_Granja2019_PBMC_scATAC \
	--prefix Celcano_predict_Granja2019_PBMC_scATAC


# gzip archr mtx
Cellcano predict -i /project/scATAC_analysis/scATAcat_review/data/Morabito2021_brainCortex_snATAC/04_peaks_and_genesScore_matrix_ArchR/ArchR_genescore \
	--trained_model /project/scATAC_analysis/scATAcat_review/results/Fig8-Zhu2023_brain_scmultiome/Cellcano_trained_model/Zhu2023_brain_trainedMLP_model \
	-o /projectscATAC_analysis/scATAcat_review/results/Fig8-Morabito2021_brainCortex_snATAC/Fig8-apply_Cellcano \
	--prefix Celcano_predict_orabito2021_brainCortex_snATAC



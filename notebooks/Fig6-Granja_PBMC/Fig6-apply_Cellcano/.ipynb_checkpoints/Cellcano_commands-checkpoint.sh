# train
> Cellcano train -i train_data_GSM3722015_PBMC_Rep1/ArchR_genescore \
	-m train_data_GSM3722015_PBMC_Rep1/train_data_GSM3722015_PBMC_Rep1_metadata_final.csv \
	-o output \
	--prefix GSM3722015_PBMC_Rep1_trained 

# test
conda activate Cellcano5
Cellcano predict -i /project/scATAC_analysis/scATAcat_review/data/Granja2019/PBMC_D10T1/05_peaks_and_genesScore_matrix_ArchR/ArchR_genescore \
	--trained_model /project/scATAC_analysis/scATAcat_review/data/Satpathy2019/PBMC_Rep1_scATAC/04_preprocessing_for_Cellcano/output \
	-o /project/scATAC_analysis/scATAcat_review/results/Fig6-Granja_PBMC_scATAC/Fig6-apply_Cellcano/output_Celcano_Granja2019_PBMC_scATAC \
	--prefix Celcano_predict_Granja2019_PBMC_scATAC
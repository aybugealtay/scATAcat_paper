# train
> Cellcano train -i train_data_GSM3722015_PBMC_Rep1/ArchR_genescore \
	-m train_data_GSM3722015_PBMC_Rep1/train_data_GSM3722015_PBMC_Rep1_metadata_final.csv \
	-o output \
	--prefix GSM3722015_PBMC_Rep1_trained 

# test
conda activate Cellcano5
Cellcano predict -i /project/scATAC_analysis/scATAcat_review/data/10X_PBMC_scmultiome/04-input_for_Cellcano/ArchR_genescore \
	--trained_model /project/scATAC_analysis/scATAcat_review/data/Satpathy2019/PBMC_Rep1_scATAC/04_preprocessing_for_Cellcano/output/GSM3722015_PBMC_Rep1_trainedMLP_model \
	-o /project/scATAC_analysis/scATAcat_review/results/Fig4_SFig2-10X_PBMC_scmultiome/Fig4-apply_Cellcano/output_PBMC_10x_scmultiome \
	--prefix predict_PBMC_10x_scmultiome
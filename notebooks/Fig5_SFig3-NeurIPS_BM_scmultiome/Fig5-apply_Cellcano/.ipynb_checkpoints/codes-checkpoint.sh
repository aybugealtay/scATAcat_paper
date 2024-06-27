### test on Neurips BM ##
> Cellcano preprocess -i ../../../data/NeurIPS_BM_scmultiome/05_input_for_Cellcano -o ../../../data/NeurIPS_BM_scmultiome/05_input_for_Cellcano -g hg38 --threads 10

# predict

Cellcano predict -i ../../../data/NeurIPS_BM_scmultiome/05_input_for_Cellcano/ArchR_genescore \
	--trained_model ../../../data/Satpathy2019/CD34_Progenitors_Rep1_scATAC/04_preprocessing_for_Cellcano/output/GSM3722029_CD34_Progenitors_Rep1_trainedMLP_model \
	-o ../../../results/Fig5_SFig3-NeurIPS_BM_scmultiome/Fig5-apply_Cellcano/output_NeurIPS2021 \
	--prefix predict_NeurIPS2021
# test
conda activate Cellcano5
# gzip archr mtx
Cellcano predict -i /project/scATAC_analysis/scATAcat_review/data/Corces2020_brain_scATAC/04_peaks_and_genesScore_matrix_ArchR/ArchR_genescore \
	--trained_model /project/scATAC_analysis/scATAcat_review/results/Fig8-Zhu2023_brain_scmultiome/Cellcano_trained_model/Zhu2023_brain_trainedMLP_model \
	-o /project/scATAC_analysis/scATAcat_review/results/Fig8-Corces2020_brain_scATAC/Fig8-apply_Cellcano \
	--prefix Celcano_predict_Corces2020_brain_scATAC_



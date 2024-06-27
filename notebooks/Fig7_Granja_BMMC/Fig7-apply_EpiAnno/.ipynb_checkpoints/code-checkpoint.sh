## training: Satpathy BM
## test: Granja BMMC scATAC
source /pkg/python-3.8.9-1/profile 
# peakrate is decreased to --peak_rate 0.05 due to memory issue
python3.8 code/run_crossdataset_projection_GPU_gameboycolor.py -d /project/scATAC_analysis/scATAcat_review/data/Satpathy2019/Bone_Marrow_Rep1/04_preprocessing_for_EpiAnno/Granja2019_BMMC_unified_peak_matrix/GSM3722071_Bone_Marrow_Rep1_Granja2019_BMMC_peaks_per_cell_matrix.hkl -c /project/scATAC_analysis/scATAcat_review/data/Satpathy2019/Bone_Marrow_Rep1/04_preprocessing_for_EpiAnno/Granja2019_BMMC_unified_peak_matrix/GSM3722071_Bone_Marrow_Rep1_cell_labels.hkl -t /project/scATAC_analysis/scATAcat_review/data/Granja2019/BMMC_D6T1/05_peaks_and_genesScore_matrix_ArchR/input_for_EpiAnno/PeakMatrix.hkl -o /project/scATAC_analysis/scATAcat_review/results/Fig7-Granja_BMMC_scATAC/Fig7-apply_EpiAnno --verbose VERBOSE --peak_rate 0.05

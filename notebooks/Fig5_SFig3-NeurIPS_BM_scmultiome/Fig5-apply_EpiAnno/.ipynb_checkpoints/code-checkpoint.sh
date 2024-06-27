## training: Satpathy BM Rep1
## test: NeurIPS BM 
source /pkg/python-3.8.9-1/profile 

python3.8 code/run_crossdataset_projection_GPU_gameboycolor.py -d /project/scATAC_analysis/scATAcat_review/data/Satpathy2019/Bone_Marrow_Rep1/04_preprocessing_for_EpiAnno/NeurIPS_unified_peak_matrix/GSM3722071_Bone_Marrow_Rep1_unified_NeurIPS_BM_peaks_per_cell_matrix.hkl -c /project/scATAC_analysis/scATAcat_review/data/Satpathy2019/Bone_Marrow_Rep1/04_preprocessing_for_EpiAnno/NeurIPS_unified_peak_matrix/GSM3722071_Bone_Marrow_Rep1_cell_labels.hkl -t /project/scATAC_analysis/scATAcat_review/data/NeurIPS_BM_scmultiome/05_input_for_EpiAnno/redo/PeakMatrix.hkl -o /project/scATAC_analysis/scATAcat_review/results/Fig5_SFig3-NeurIPS_BM_scmultiome/Fig5-apply_EpiAnno/SatpathyBM_with_NeurIPS_BM_peaks/ --verbose VERBOSE 

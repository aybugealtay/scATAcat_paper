import pandas as pd
import pickle
import scipy.sparse
import hickle
import numpy as np

# from step 01 of the pipeline
per_cell_peak_map = pd.read_table("/project/scATAC_analysis/scATAcat_review/data/Satpathy2019/CD34_Progenitors_Rep1_scATAC/04_preprocessing_for_EpiAnno/Buenrostro2018_FACS_BM_unified_peak_matrix/_GSM3722029_CD34_Progenitors_Rep1_liftOverhg38_Buenrostro2018_FACS_BM_unified_mapping.bed",delimiter="\t",header=None)
per_cell_peak_map.columns = ["chr", "start", "end", "cellIDs", "coverage"]
per_cell_peak_map['region']=per_cell_peak_map['chr'].astype(str)+'_'+per_cell_peak_map['start'].astype(str)+'_'+per_cell_peak_map['end'].astype(str)
# export cCREs
pd.DataFrame(per_cell_peak_map['region']).to_csv("/project/scATAC_analysis/scATAcat_review/data/Satpathy2019/CD34_Progenitors_Rep1_scATAC/04_preprocessing_for_EpiAnno/Buenrostro2018_FACS_BM_unified_peak_matrix/GSM3722029_CD34_Progenitors_Rep1_unified_Buenrostro2018_FACS_BM_peaks.csv")

metadata= pd.read_csv("/project/scATAC_analysis/scATAcat_review/benchmarking/Cellcano/apply_CD34cells/train_data_GSM3722029_CD34_Progenitors_Rep1/train_data_GSM3722029_CD34_Progenitors_Rep1_metadata_final.csv",delimiter=",",header=0)
filtered_cell_list = metadata[["Barcodes"]]
filtered_cell_list.columns = ["cellIDs"]
peak_by_cell_df = pd.DataFrame(index=per_cell_peak_map['region'].tolist(),columns=filtered_cell_list['cellIDs'].tolist())
index_counter=0
    # sometimes a region doesn't have any reads mapping. in these cases bedmap gives "." as an output. This is to replace it with NA
per_cell_peak_map = per_cell_peak_map.replace('\.+', '0', regex=True)

with open('/project/scATAC_analysis/scATAcat_review/data/Satpathy2019/CD34_Progenitors_Rep1_scATAC/04_preprocessing_for_EpiAnno/Buenrostro2018_FACS_BM_unified_peak_matrix/GSM3722029_CD34_Progenitors_Rep1_unified_Buenrostro2018_FACS_BM_per_cell_map.pkl', 'wb') as f:
    pickle.dump(per_cell_peak_map, f)
    
for region in per_cell_peak_map["region"]:
    cell_to_coverage_dict = {k: v for k, v in zip(per_cell_peak_map.iloc[index_counter,3].split(","), list(map(int, per_cell_peak_map.iloc[index_counter,4].split(","))))}
    peak_by_cell_df.loc[region] = pd.Series(cell_to_coverage_dict)
    # here we turn all the NAs to 0 
    peak_by_cell_df.loc[region].fillna(0, inplace=True)
    index_counter = index_counter +1

# Saving the objects:
with open('/project/scATAC_analysis/scATAcat_review/data/Satpathy2019/CD34_Progenitors_Rep1_scATAC/04_preprocessing_for_EpiAnno/Buenrostro2018_FACS_BM_unified_peak_matrix/GSM3722029_CD34_Progenitors_Rep1_unified_Buenrostro2018_FACS_BM_peaks_per_cell_matrix.pkl', 'wb') as f:
    pickle.dump(peak_by_cell_df, f)
# cast to np array and export as hickle

peak_by_cell_np_array = (np.array(peak_by_cell_df)).astype(np.float32)

hickle.dump(peak_by_cell_np_array, '/project/scATAC_analysis/scATAcat_review/data/Satpathy2019/CD34_Progenitors_Rep1_scATAC/04_preprocessing_for_EpiAnno/Buenrostro2018_FACS_BM_unified_peak_matrix/GSM3722071_Bone_Marrow_Rep1_unified_Buenrostro2018_FACS_BM_peaks_per_cell_matrix.hkl', mode='w')

# export also the lables

cell_labels = np.array(metadata[['celltype']])
hickle.dump(cell_labels, '/project/scATAC_analysis/scATAcat_review/data/Satpathy2019/CD34_Progenitors_Rep1_scATAC/04_preprocessing_for_EpiAnno/Buenrostro2018_FACS_BM_unified_peak_matrix/GSM3722071_Bone_Marrow_Rep1_cell_labels.hkl', mode='w')
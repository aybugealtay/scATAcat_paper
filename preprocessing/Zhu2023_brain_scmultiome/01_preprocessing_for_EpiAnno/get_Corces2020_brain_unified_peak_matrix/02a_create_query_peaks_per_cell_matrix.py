import pandas as pd
import pickle
import scipy.sparse
import hickle
import numpy as np

# from step 01 of the pipeline
per_cell_peak_map = pd.read_table("/project/scATAC_analysis/scATAcat_review/data/Zhu2023_brain_scmultiome/01_preprocessing_for_Cellcano/Corces2020_brain_unified_peak_matrix/Zhu2023_brain_adult1_Corces2020_brain_unified_mapping.bed",delimiter="\t",header=None)
per_cell_peak_map.columns = ["chr", "start", "end", "cellIDs", "coverage"]
per_cell_peak_map['region']=per_cell_peak_map['chr'].astype(str)+'_'+per_cell_peak_map['start'].astype(str)+'_'+per_cell_peak_map['end'].astype(str)
# export cCREs
pd.DataFrame(per_cell_peak_map['region']).to_csv("/project/scATAC_analysis/scATAcat_review/data/Zhu2023_brain_scmultiome/01_preprocessing_for_Cellcano/Corces2020_brain_unified_peak_matrix/Zhu2023_brain_adult1_Corces2020_brain_peaks.csv")

metadata= pd.read_csv("/project/scATAC_analysis/scATAcat_review/data/Zhu2023_brain_scmultiome/metadata/Zhu2023_brainCortex_adult1_metadata.csv",delimiter=",",header=0)
filtered_cell_list = metadata[["cell_IDs"]]
filtered_cell_list.columns = ["cellIDs"]
peak_by_cell_df = pd.DataFrame(index=per_cell_peak_map['region'].tolist(),columns=filtered_cell_list['cellIDs'].tolist())
index_counter=0
    # sometimes a region doesn't have any reads mapping. in these cases bedmap gives "." as an output. This is to replace it with NA
per_cell_peak_map = per_cell_peak_map.replace('\.+', '0', regex=True)

with open('/project/scATAC_analysis/scATAcat_review/data/Zhu2023_brain_scmultiome/01_preprocessing_for_Cellcano/Corces2020_brain_unified_peak_matrix/Zhu2023_brain_adult1_Corces2020_brain_per_cell_map.pkl', 'wb') as f:
    pickle.dump(per_cell_peak_map, f)
    
for region in per_cell_peak_map["region"]:
    cell_to_coverage_dict = {k: v for k, v in zip(per_cell_peak_map.iloc[index_counter,3].split(","), list(map(int, per_cell_peak_map.iloc[index_counter,4].split(","))))}
    peak_by_cell_df.loc[region] = pd.Series(cell_to_coverage_dict)
    # here we turn all the NAs to 0 
    peak_by_cell_df.loc[region].fillna(0, inplace=True)
    index_counter = index_counter +1

# Saving the objects:
with open('/project/scATAC_analysis/scATAcat_review/data/Zhu2023_brain_scmultiome/01_preprocessing_for_Cellcano/Corces2020_brain_unified_peak_matrix/Zhu2023_brain_adult1_Corces2020_brain_per_cell_matrix.pkl', 'wb') as f:
    pickle.dump(peak_by_cell_df, f)
# cast to np array and export as hickle

peak_by_cell_np_array = (np.array(peak_by_cell_df)).astype(np.float32)

hickle.dump(peak_by_cell_np_array, '/project/scATAC_analysis/scATAcat_review/data/Zhu2023_brain_scmultiome/01_preprocessing_for_Cellcano/Corces2020_brain_unified_peak_matrix/Zhu2023_brain_adult1_Corces2020_brain_per_cell_matrix.hkl', mode='w')

# export also the lables

cell_labels = np.array(metadata[['celltype']])
hickle.dump(cell_labels, '/project/scATAC_analysis/scATAcat_review/data/Zhu2023_brain_scmultiome/01_preprocessing_for_Cellcano/Corces2020_brain_unified_peak_matrix/Zhu2023_brain_cell_labels.hkl', mode='w')
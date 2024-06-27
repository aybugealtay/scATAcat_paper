import pandas as pd
import pickle
import time
import scipy.sparse
start = time.time()
print("timer has started")

# from step 01 of the pipeline
per_cell_encode_cCRE_map = pd.read_table("/project/scATAC_analysis/scATAcat_review/data/Satpathy2019/PBMC_Rep1_scATAC/02_ENCODE_cCRE_coverage/GSM3722015_PBMC_Rep1_liftOverhg38_sorted_fragments_only_stdChr_ENCORE_cCRE_regions.bed",delimiter="\t",header=None)
per_cell_encode_cCRE_map.columns = ["chr", "start", "end", "cellIDs", "coverage"]
per_cell_encode_cCRE_map['region']=per_cell_encode_cCRE_map['chr'].astype(str)+'_'+per_cell_encode_cCRE_map['start'].astype(str)+'_'+per_cell_encode_cCRE_map['end'].astype(str)
# export cCREs
pd.DataFrame(per_cell_encode_cCRE_map['region']).to_csv("/project/scATAC_analysis/scATAcat_review/data/Satpathy2019/PBMC_Rep1_scATAC/03_ENCODE_coverage_by_cell_matrix/GSM3722015_PBMC_Rep1_ENCODE_cCREs.csv")
# these are the cells obtained from here: scATAC_analysis/NeurIPS2021_BM_scmultiome/analysis/01_get_cCRE_by_cell_matrix/01_b_get_cell_IDs.ipynb
filtered_cell_list=  pd.read_csv("/project/scATAC_analysis/scATAcat_review/data/Satpathy2019/PBMC_Rep1_scATAC/03_ENCODE_coverage_by_cell_matrix/cellIDs.csv",delimiter=",",header=0, index_col=0)
filtered_cell_list.columns = ["cellIDs"]
encode_cCRE_by_cell_df = pd.DataFrame(index=per_cell_encode_cCRE_map['region'].tolist(),columns=filtered_cell_list['cellIDs'].tolist())
index_counter=0
    # sometimes a region doesn't have any reads mapping. in these cases bedmap gives "." as an output. This is to replace it with NA
per_cell_encode_cCRE_map = per_cell_encode_cCRE_map.replace('\.+', '0', regex=True)

with open('/project/scATAC_analysis/scATAcat_review/data/Satpathy2019/PBMC_Rep1_scATAC/03_ENCODE_coverage_by_cell_matrix/GSM3722015_PBMC_Rep1_per_cell_encode_cCRE_map.pkl', 'wb') as f:
    pickle.dump(per_cell_encode_cCRE_map, f)
    
for region in per_cell_encode_cCRE_map["region"]:
    cell_to_coverage_dict = {k: v for k, v in zip(per_cell_encode_cCRE_map.iloc[index_counter,3].split(","), list(map(int, per_cell_encode_cCRE_map.iloc[index_counter,4].split(","))))}
    encode_cCRE_by_cell_df.loc[region] = pd.Series(cell_to_coverage_dict)
    # here we turn all the NAs to 0 
    encode_cCRE_by_cell_df.loc[region].fillna(0, inplace=True)
    index_counter = index_counter +1

# Saving the objects:
with open('/project/scATAC_analysis/scATAcat_review/data/Satpathy2019/PBMC_Rep1_scATAC/03_ENCODE_coverage_by_cell_matrix/GSM3722015_PBMC_Rep1_per_cell_encode_cCRE_matrix.pkl', 'wb') as f:
    pickle.dump(encode_cCRE_by_cell_df, f)
# cast to csr matrix
#encode_cCRE_by_cell_csr_int64= scipy.sparse.csr_matrix(encode_cCRE_by_cell_df.astype(pd.SparseDtype("int64",0)).sparse.to_coo())

encode_cCRE_by_cell_csr_float32= scipy.sparse.csr_matrix(encode_cCRE_by_cell_df.astype(pd.SparseDtype("float32",0)).sparse.to_coo())

#with open('../../data/NeurIPS_BM_scmultiome/04_ENCODE_coverage_by_prototypes_matrix/NeurIPS_BM_scmultiome_s1d1_per_cell_encode_cCRE_matrix_csr_int64.pkl', 'wb') as f:
#    pickle.dump(encode_cCRE_by_cell_csr_int64, f)

with open('/project/scATAC_analysis/scATAcat_review/data/Satpathy2019/PBMC_Rep1_scATAC/03_ENCODE_coverage_by_cell_matrix/GSM3722015_PBMC_Rep1_per_cell_encode_cCRE_matrix_sparse.pkl', 'wb') as f:
    pickle.dump(encode_cCRE_by_cell_csr_float32, f)

end = time.time()
print("ellapsed time in seconds:")
print(end - start)
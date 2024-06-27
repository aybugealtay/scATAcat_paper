import pandas as pd
import pickle
import scipy.sparse

# from step 01 of the pipeline
per_cell_encode_cCRE_map = pd.read_table("../../../data/Granja2019/BMMC_D6T1/02_ENCODE_cCRE_coverage/GSM4138889_scATAC_BMMC_D6T1_liftOverhg38_no_chrMt_sorted_ENCODE_cCRE_regions.bed",delimiter="\t",header=None)
per_cell_encode_cCRE_map.columns = ["chr", "start", "end", "cellIDs", "coverage"]
per_cell_encode_cCRE_map['region']=per_cell_encode_cCRE_map['chr'].astype(str)+'_'+per_cell_encode_cCRE_map['start'].astype(str)+'_'+per_cell_encode_cCRE_map['end'].astype(str)
# expoer cCREs
pd.DataFrame(per_cell_encode_cCRE_map['region']).to_csv("../../../data/Granja2019/BMMC_D6T1/02_ENCODE_cCRE_coverage/GSM4138889_scATAC_BMMC_D6T1_ENCODE_cCREs.csv")
# these are the cells obtained from here: scATAC_analysis/NeurIPS2021_BM_scmultiome/analysis/01_get_cCRE_by_cell_matrix/01_b_get_cell_IDs.ipynb
filtered_cell_list= pd.read_csv('../../../data/Granja2019/BMMC_D6T1/03_cellIDs_and_annotations/cell_IDs.csv',delimiter=",",header=0)
filtered_cell_list.columns = ["cellIDs"]
encode_cCRE_by_cell_df = pd.DataFrame(index=per_cell_encode_cCRE_map['region'].tolist(),columns=filtered_cell_list['cellIDs'].tolist())
index_counter=0
    # sometimes a region doesn't have any reads mapping. in these cases bedmap gives "." as an output. This is to replace it with NA
per_cell_encode_cCRE_map = per_cell_encode_cCRE_map.replace('\.+', '0', regex=True)

with open('../../../data/Granja2019/BMMC_D6T1/02_ENCODE_cCRE_coverage/GSM4138889_scATAC_BMMC_D6T1_per_cell_encode_cCRE_map.pkl', 'wb') as f:
    pickle.dump(per_cell_encode_cCRE_map, f)
    
for region in per_cell_encode_cCRE_map["region"]:
    cell_to_coverage_dict = {k: v for k, v in zip(per_cell_encode_cCRE_map.iloc[index_counter,3].split(","), list(map(int, per_cell_encode_cCRE_map.iloc[index_counter,4].split(","))))}
    encode_cCRE_by_cell_df.loc[region] = pd.Series(cell_to_coverage_dict)
    # here we turn all the NAs to 0 
    encode_cCRE_by_cell_df.loc[region].fillna(0, inplace=True)
    index_counter = index_counter +1

# Saving the objects:
with open('../../../data/Granja2019/BMMC_D6T1/04_ENCODE_coverage_by_cell_matrix/GSM4138889_scATAC_BMMC_D6T1_per_cell_encode_cCRE_matrix.pkl', 'wb') as f:
    pickle.dump(encode_cCRE_by_cell_df, f)

encode_cCRE_by_cell_csr_float32= scipy.sparse.csr_matrix(encode_cCRE_by_cell_df.astype(pd.SparseDtype("float32",0)).sparse.to_coo())


with open('../../../data/Granja2019/BMMC_D6T1/04_ENCODE_coverage_by_cell_matrix/GSM4138889_scATAC_BMMC_D6T1_per_cell_encode_cCRE_matrix_sparse.pkl', 'wb') as f:
    pickle.dump(encode_cCRE_by_cell_csr_float32, f)

import pandas as pd
import pickle

per_cell_encode_cCRE_map = pd.read_table("/../../data/preprocessing/10X_PBMC_scmultiome/01_ENCODE_cCRE_coverage/pbmc_granulocyte_sorted_10k_atac_fragments_ENCORE_cCRE_regions.bed",delimiter="\t",header=None)
per_cell_encode_cCRE_map.columns = ["chr", "start", "end", "cellIDs", "coverage"]
per_cell_encode_cCRE_map['region']=per_cell_encode_cCRE_map['chr'].astype(str)+'_'+per_cell_encode_cCRE_map['start'].astype(str)+'_'+per_cell_encode_cCRE_map['end'].astype(str)

# these are the cells that re filtered by 10X
filtered_cell_list = pd.read_csv("/../../data/preprocessing/10X_PBMC_scmultiome/filtered_cellIDs.csv",delimiter=",",header=None, index_col=None)
filtered_cell_list.drop(filtered_cell_list.tail(1).index,inplace=True) # drop last rows, it is a rowname
filtered_cell_list.columns = ["celIDs"]
encode_cCRE_by_cell_df = pd.DataFrame(index=per_cell_encode_cCRE_map['region'].tolist(),columns=filtered_cell_list['celIDs'].tolist())
index_counter=0
for region in per_cell_encode_cCRE_map["region"]:
    cell_to_coverage_dict = {k: v for k, v in zip(per_cell_encode_cCRE_map.iloc[index_counter,3].split(","), per_cell_encode_cCRE_map.iloc[index_counter,4].split(","))}
    encode_cCRE_by_cell_df.loc[region] = pd.Series(cell_to_coverage_dict)
    index_counter = index_counter +1

ENCODE_coverage_per_cell_matrix = ENCODE_coverage_per_cell_matrix.fillna(0)
encode_cCRE_by_cell_csr = scipy.sparse.csr_matrix(ENCODE_coverage_per_cell_matrix.astype(pd.SparseDtype("float32",0)).sparse.to_coo())

pd.DataFrame(ENCODE_coverage_per_cell_matrix.index, columns=['cCREs']).to_csv("/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/10X_PBMC_scmultiome/02_ENCODE_coverage_by_cell_matrix/ENCODE_coverage_per_cell_ENCODE_cCREs.csv")
pd.DataFrame(ENCODE_coverage_per_cell_matrix.columns, columns=['cell_IDs']).to_csv("/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/10X_PBMC_scmultiome/02_ENCODE_coverage_by_cell_matrix/ENCODE_coverage_per_cell_cell_IDs.csv")



# Saving the objects:
with open('/../../data/preprocessing/10X_PBMC_scmultiome/01_ENCODE_cCRE_coverag/ENCODE_coverage_per_cell_matrix.pkl', 'wb') as f:
    pickle.dump(encode_cCRE_by_cell_df, f)


# Saving the objects:
with open('/../../data/preprocessing/10X_PBMC_scmultiome/01_ENCODE_cCRE_coverag/ENCODE_coverage_per_cell_matrix_sparse.pkl', 'wb') as f:
    pickle.dump(encode_cCRE_by_cell_csr, f)
import pandas as pd
import pickle
import scipy.sparse
per_cell_encode_cCRE_map = pd.read_table("../../data/Morabito2021_brainCortex_snATAC/01_ENCODE_cCRE_coverage/Morabito2021_brainCortex_atac_fragments_ENCORE_cCRE_regions.bed",delimiter="\t",header=None)
per_cell_encode_cCRE_map.columns = ["chr", "start", "end", "cellIDs", "coverage"]
per_cell_encode_cCRE_map['region']=per_cell_encode_cCRE_map['chr'].astype(str)+'_'+per_cell_encode_cCRE_map['start'].astype(str)+'_'+per_cell_encode_cCRE_map['end'].astype(str)

# these are the cells that re filtered by 10X
filtered_cell_list = pd.read_csv("../../data/Morabito2021_brainCortex_snATAC/00_mapping/cr_count_SRR14514144_2024-05-22/outs/filtered_peak_bc_matrix/barcodes.tsv",delimiter=",",header=None, index_col=None)
filtered_cell_list.drop(filtered_cell_list.tail(1).index,inplace=True) # drop last rows, it is a rowname
filtered_cell_list.columns = ["celIDs"]
ENCODE_coverage_per_cell_matrix = pd.DataFrame(index=per_cell_encode_cCRE_map['region'].tolist(),columns=filtered_cell_list['celIDs'].tolist())
index_counter=0
for region in per_cell_encode_cCRE_map["region"]:
    cell_to_coverage_dict = {k: v for k, v in zip(per_cell_encode_cCRE_map.iloc[index_counter,3].split(","), per_cell_encode_cCRE_map.iloc[index_counter,4].split(","))}
    ENCODE_coverage_per_cell_matrix.loc[region] = pd.Series(cell_to_coverage_dict)
    index_counter = index_counter +1

ENCODE_coverage_per_cell_matrix = ENCODE_coverage_per_cell_matrix.fillna(0)

pd.DataFrame(ENCODE_coverage_per_cell_matrix.index, columns=['cCREs']).to_csv("../../data/Morabito2021_brainCortex_snATAC/02_ENCODE_coverage_by_cell_matrix/ENCODE_coverage_per_cell_ENCODE_cCREs.csv")
pd.DataFrame(ENCODE_coverage_per_cell_matrix.columns, columns=['cell_IDs']).to_csv("../../data/Morabito2021_brainCortex_snATAC/02_ENCODE_coverage_by_cell_matrix/ENCODE_coverage_per_cell_cell_IDs.csv")

# Saving the objects:
with open('../../data/Morabito2021_brainCortex_snATAC/02_ENCODE_coverage_by_cell_matrix/ENCODE_coverage_per_cell_matrix.pkl', 'wb') as f:
    pickle.dump(ENCODE_coverage_per_cell_matrix, f)
    
ENCODE_coverage_per_cell_matrix_csr = scipy.sparse.csr_matrix(ENCODE_coverage_per_cell_matrix.astype(pd.SparseDtype("float32",0)).sparse.to_coo())

# Saving the objects:
with open('../../data/Morabito2021_brainCortex_snATAC/02_ENCODE_coverage_by_cell_matrix/ENCODE_coverage_per_cell_matrix_sparse.pkl', 'wb') as f:
    pickle.dump(ENCODE_coverage_per_cell_matrix_csr, f)
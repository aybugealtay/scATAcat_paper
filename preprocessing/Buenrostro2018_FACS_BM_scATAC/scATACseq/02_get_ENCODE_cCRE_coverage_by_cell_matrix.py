import pandas as pd
import pickle
import os
import scipy.sparse

cCREs= pd.read_table("/../../../data/ENCODE_cCREs/V2.hg38-cCREs-Final_sorted.bed",delimiter="        ",header=None,engine='python')
regions = ['_'.join(i) for i in zip(cCREs.iloc[:,0],cCREs.iloc[:,1].map(str), cCREs.iloc[:,2].map(str))]

coverage_path= "../../../data/Buenrostro2018_FACS_BM_scATAC/scATACseq/01_ENCODE_cCRE_coverage/"
coverage_directory = os.fsencode(coverage_path)
encode_cCRE_by_cell_df = pd.DataFrame(index=regions)
for file in os.listdir(coverage_directory):
    ext = os.path.splitext(file)[-1].lower()
    if ext==b'.bed':
        filename = os.fsdecode(file)
        print(filename)
        cell_ID= '_'.join(filename.split("_", 2)[0:2])
        per_cell_full_path = coverage_path +filename
        per_cell_encode_cCRE_map = pd.read_table(per_cell_full_path,delimiter="\t",header=None)
        per_cell_encode_cCRE_map['region']= ['_'.join(i) for i in zip(per_cell_encode_cCRE_map.iloc[:,0],per_cell_encode_cCRE_map.iloc[:,1].map(str), per_cell_encode_cCRE_map.iloc[:,2].map(str))]
        per_cell_encode_cCRE_map = per_cell_encode_cCRE_map.set_index("region")
        sub_map = pd.DataFrame(list(per_cell_encode_cCRE_map.iloc[:,6]), columns=[cell_ID], index=per_cell_encode_cCRE_map.index)
        encode_cCRE_by_cell_df = pd.concat([encode_cCRE_by_cell_df, sub_map], axis=1).reindex(encode_cCRE_by_cell_df.index)
    
#encode_cCRE_by_cell_df_nonzero = encode_cCRE_by_cell_df.loc[:, (encode_cCRE_by_cell_df != 0).any(axis=0)]
    
    
# Saving the objects:
with open('../../../data/Buenrostro2018_FACS_BM_scATAC/scATACseq/02_ENCODE_coverage_by_prototypes_matrix/scATAC_BM_Corces2018_ENCODE_coverage_per_cell_matrix_complete.pkl', 'wb') as f:
    pickle.dump(encode_cCRE_by_cell_df, f)
    
encode_cCRE_by_cell_df.to_csv("../../../data/Buenrostro2018_FACS_BM_scATAC/scATACseq/02_ENCODE_coverage_by_prototypes_matrix/scATAC_BM_Corces2018_ENCODE_coverage_per_cell_matrix_complete.csv")

## convert to sparse

encode_cCRE_by_cell_csr = scipy.sparse.csr_matrix(encode_cCRE_by_cell_df.astype(pd.SparseDtype("float32",0)).sparse.to_coo())


# Saving the objects:
with open('../../../data/Buenrostro2018_FACS_BM_scATAC/scATACseq/02_ENCODE_coverage_by_cell_matrix/scATAC_BM_Corces2018_ENCODE_coverage_per_cell_matrix_complete_sparse.pkl', 'wb') as f:
    pickle.dump(encode_cCRE_by_cell_csr, f)

# also export the cell names and feature names

ENCODE_cCREs = pd.DataFrame(encode_cCRE_by_cell_df.index)
ENCODE_cCREs.columns = ['cCREs']
ENCODE_cCREs.index = ENCODE_cCREs['cCREs']

filtered_cell_IDs = pd.DataFrame(encode_cCRE_by_cell_df.columns)
filtered_cell_IDs.columns = ["cell_IDs"]
filtered_cell_IDs.index = filtered_cell_IDs["cell_IDs"]
filtered_cell_IDs.head()

ENCODE_cCREs.to_csv("../../../data/Buenrostro2018_FACS_BM_scATAC/scATACseq/02_ENCODE_coverage_by_cell_matrix/scATAC_BM_Corces2018_ENCODE_coverage_per_cell_matrix_complete_features.csv")


filtered_cell_IDs.to_csv("../../../data/Buenrostro2018_FACS_BM_scATAC/scATACseq/02_ENCODE_coverage_by_cell_matrix/scATAC_BM_Corces2018_ENCODE_coverage_per_cell_matrix_complete_cell_IDs.csv")

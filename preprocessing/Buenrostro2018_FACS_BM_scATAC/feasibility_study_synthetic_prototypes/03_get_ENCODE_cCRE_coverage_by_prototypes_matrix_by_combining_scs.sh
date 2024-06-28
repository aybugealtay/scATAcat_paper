import pandas as pd
import pickle
import os

cCREs= pd.read_table("../../../data/ENCODE_cCREs/V2.hg38-cCREs-3col_sorted.bed",delimiter="        ",header=None,engine='python')
regions = ['_'.join(i) for i in zip(cCREs.iloc[:,0],cCREs.iloc[:,1].map(str), cCREs.iloc[:,2].map(str))]

coverage_path= "../../../data/Buenrostro2018_FACS_BM_scATAC/feasibility_study_synthetic_prototypes/01_synthetic_prototypes_ENCODE_cCRE_coverage/"
coverage_directory = os.fsencode(coverage_path)
encode_cCRE_by_cell_df = pd.DataFrame(index=regions)
for file in os.listdir(coverage_directory):
    file_str = file.decode('utf-8')
    #ext = os.path.splitext(file)[-1].lower()
    if file_str.endswith('coverage.bed'):
        filename = os.fsdecode(file)
        print(filename)
        cell_ID= '_'.join(filename.split("_", 2)[0:2])
        per_cell_full_path = coverage_path +filename
        per_cell_encode_cCRE_map = pd.read_table(per_cell_full_path,delimiter="\t",header=None)
        per_cell_encode_cCRE_map['region']= ['_'.join(i) for i in zip(per_cell_encode_cCRE_map.iloc[:,0],per_cell_encode_cCRE_map.iloc[:,1].map(str), per_cell_encode_cCRE_map.iloc[:,2].map(str))]
        per_cell_encode_cCRE_map = per_cell_encode_cCRE_map.set_index("region")
        sub_map = pd.DataFrame(list(per_cell_encode_cCRE_map.iloc[:,6]), columns=[cell_ID], index=per_cell_encode_cCRE_map.index)
        encode_cCRE_by_cell_df = pd.concat([encode_cCRE_by_cell_df, sub_map], axis=1).reindex(encode_cCRE_by_cell_df.index)
    
# Saving the objects:
with open('../../../data/Buenrostro2018_FACS_BM_scATAC/feasibility_study_synthetic_prototypes/02_ENCODE_coverage_by_prototypes_matrix/scATAC_BM_Corces2018_sc_aggregated_pseudobulk_ENCODE_coverage_per_cell_matrix_complete.pkl', 'wb') as f:
    pickle.dump(encode_cCRE_by_cell_df, f)
    
encode_cCRE_by_cell_df.to_csv("../../../data/Buenrostro2018_FACS_BM_scATAC/feasibility_study_synthetic_prototypes/02_ENCODE_coverage_by_prototypes_matrix/scATAC_BM_Corces2018_sc_aggregated_pseudobulk_ENCODE_coverage_per_cell_matrix_complete.csv")
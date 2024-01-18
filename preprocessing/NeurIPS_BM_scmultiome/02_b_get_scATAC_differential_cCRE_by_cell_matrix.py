import pandas as pd
import pickle
import numpy as np
from scipy import sparse
import scipy.io as sio
import scipy.stats as stats
with open('/project/scATAC_analysis/DOGMA-seq/pbmc_stim_multiome/analysis/02_get_cCRE_by_cell_coverage/outs/DOGMAseq_scATAC_PBMC_LLL_CTRL_ENCODE_coverage_per_cell_matrix_.pkl', "rb") as f: 
    ENCODE_coverage_per_cell_matrix = pickle.load(f)
    
#filter the matrix for the differential cCREs

ENCODE_cCREs = pd.read_csv("/project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/Corces2016_differential_cCREs/Corces2016_with_Calderon_pDC/outs/Corces2016_pairwise_differential_cCREs_FDR0.05_top2000_of_each_pair_sorted_exactCREs.csv", header=None)

diff_ENCODE_coverage_per_cell_matrix = ENCODE_coverage_per_cell_matrix.loc[ENCODE_cCREs[0]]#replace NA with 0
diff_ENCODE_coverage_per_cell_matrix = diff_ENCODE_coverage_per_cell_matrix.fillna(0)
# Saving the objects:

with open('/project/scATAC_analysis/DOGMA-seq/pbmc_stim_multiome/analysis/02_get_cCRE_by_cell_coverage/outs/DOGMAseq_scATAC_PBMC_LLL_CTRL_differential_ENCODE_coverage_per_cell_matrix_overlappingPeaks.pkl', 'wb') as f:
    pickle.dump(diff_ENCODE_coverage_per_cell_matrix, f)

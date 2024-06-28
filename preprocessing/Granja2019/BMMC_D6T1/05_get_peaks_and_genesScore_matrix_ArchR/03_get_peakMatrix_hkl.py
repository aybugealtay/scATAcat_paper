import pandas as pd
import pickle
import hickle
import numpy as np

peak_by_cell_df = pd.read_csv('/project/scATAC_analysis/scATAcat_review/data/Buenrostro2018_FACS_BM_scATAC/scATAC/03_input_for_EpiAnno/PeakMatrix_dense.csv', index_col=0)

peak_by_cell_np_array = (np.array(peak_by_cell_df)).astype(np.float32)
hickle.dump(peak_by_cell_np_array, '/project/scATAC_analysis/scATAcat_review/data/Buenrostro2018_FACS_BM_scATAC/scATAC/03_input_for_EpiAnno/PeakMatrix.hkl', mode='w')
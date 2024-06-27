import pandas as pd
import pickle
import hickle
import numpy as np

peak_by_cell_df = pd.read_csv('/project/scATAC_analysis/scATAcat_review/data/Granja2019/BMMC_D6T1/05_peaks_and_genesScore_matrix_ArchR/input_for_EpiAnno/PeakMatrix_dense.csv', index_col=0)

peak_by_cell_np_array = (np.array(peak_by_cell_df)).astype(np.float32)
hickle.dump(peak_by_cell_np_array, '/project/scATAC_analysis/scATAcat_review/data/Granja2019/BMMC_D6T1/05_peaks_and_genesScore_matrix_ArchR/input_for_EpiAnno/PeakMatrix.hkl', mode='w')
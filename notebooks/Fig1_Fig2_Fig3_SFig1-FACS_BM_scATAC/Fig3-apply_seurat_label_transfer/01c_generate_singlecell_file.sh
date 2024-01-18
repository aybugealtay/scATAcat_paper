## generate singlecell.csv file

#singlecell.csv file includes per-parcode-info, like "is_cell_barcode", "number of fragments". I will aggregate the info from the fragments file
cd ../../../results/Fig1_Fig2_Fig3_SFig1-FACS_BM_scATAC/Fig3-apply_seurat_label_transfer/01_prepare_input_files

# this code iterates over the cells and aggregates # number of fragments per cell
awk '{
    arr[$4]+=$5
   }
   END {
     for (key in arr) printf("%s\t%s\n", key, arr[key])
   }' Corces2018_BM_FACS_scATAC_fragments_reorganized_tab_sorted.sort.bed  \
   | sort -k1,1 > sum.bed
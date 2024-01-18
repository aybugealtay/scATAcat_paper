BEDPATH="../../../data/Buenrostro2018_FACS_BM_scATAC/scATACseq/01_ENCODE_cCRE_coverage/*.bed"
cd "../../../results/Fig1_Fig2_Fig3_SFig1-FACS_BM_scATAC/Fig3-apply_seurat_label_transfer/01_prepare_input_files"
BEDLIST=$(ls $BEDPATH)
for bed in $BEDLIST
do
  echo $bed
  filename=$(basename -- $bed)
  IFS='_' read -r -a array <<< $filename
  cell_ID=${array[0]}_${array[1]}
  # read the bed file, 
    # choose 1,2,3,7 columns --> {print $1, $2, $3, $7}' 
  # check if the count is more than zero -> $7>0
  # in order to use defined variable within awk, you need to define the variable with awk --> -v myvar=$cell_ID source: https://linuxhint.com/awk_command_variables/
  # if the count column is > 0, make a file with "chr start stop count cellID" 
  # tab seperated --> BEGIN {OFS="\t"};
  awk -v myvar=$cell_ID 'BEGIN {OFS="\t"}; $7>0 {print $1, $2, $3, $7, myvar}' $bed >> Corces2018_BM_FACS_scATAC_fragments.bed
done

### 1. 5th column of the bed file needs to be the count.
> awk 'BEGIN {OFS="\t"}; {print $1, $2, $3, $5, $4}' Corces2018_BM_FACS_scATAC_fragments.bed > Corces2018_BM_FACS_scATAC_fragments_reorganized.bed

### 2. Somehow the output is not tab seperated. change all the spaces to tab
perl -pe 's/  */\t/g' Corces2018_BM_FACS_scATAC_fragments_reorganized.bed > Corces2018_BM_FACS_scATAC_fragments_reorganized_tab.bed

### 3. sort the bed file
sort -k1,1 -k2,2n Corces2018_BM_FACS_scATAC_fragments_reorganized_tab.bed > Corces2018_BM_FACS_scATAC_fragments_reorganized_tab_sorted.bed



### sort, compress, and index
>sort -k1,1 -k2,2n Corces2018_BM_FACS_scATAC_fragments_reorganized_tab_sorted.bed > Corces2018_BM_FACS_scATAC_fragments_reorganized_tab_sorted.sort.bed
bgzip -@ 8 -k Corces2018_BM_FACS_scATAC_fragments_reorganized_tab_sorted.sort.bed
tabix -p bed Corces2018_BM_FACS_scATAC_fragments_reorganized_tab_sorted.sort.bed.gz
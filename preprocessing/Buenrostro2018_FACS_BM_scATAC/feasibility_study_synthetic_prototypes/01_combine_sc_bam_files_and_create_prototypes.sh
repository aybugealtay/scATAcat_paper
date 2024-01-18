for cell_type in CMP HSC GMP MEP MPP CLP LMPP 
#for cell_type in CMP
do
  echo $cell_type
  cell_type_path=/project/scATAC_analysis/Corces2018_BM_FACS_scATAC/ENCODE_v3_preprocessed/$cell_type/
  end_idx=$(($(ls -1 ${cell_type_path} | wc -l)-1)) 
  # declare array to combine bam paths:
  sc_bam_path_list=()
  combined_bam_path=/project/scATAC_analysis/Corces2018_BM_FACS_scATAC/analysis/get_pseudobulk_as_combined_scs/2replicates_per_cellType/combined_bam_files/
  combined_bam_name_rep1=${cell_type}_1_combined.bam
  combined_bam_name_rep2=${cell_type}_2_combined.bam
  # make two replicates
  for idx in $(seq 0 $(($end_idx/2)))
   do
     cell_id_path=/project/scATAC_analysis/Corces2018_BM_FACS_scATAC/ENCODE_v3_preprocessed/$cell_type/${cell_type}_$idx
     cell_type_atac_path=/project/scATAC_analysis/Corces2018_BM_FACS_scATAC/ENCODE_v3_preprocessed/$cell_type/${cell_type}_${idx}/atac
     cell_type_bam_path=/project/scATAC_analysis/Corces2018_BM_FACS_scATAC/ENCODE_v3_preprocessed/$cell_type/${cell_type}_${idx}/atac/*/call-filter/shard-0/execution/
     # check if the path exist
     if [ -d $cell_type_bam_path ]; then 
         bam=$(ls ${cell_type_bam_path} | grep '\.bam$') 
         cell_type_bam_path_w_bam=${cell_type_bam_path}$bam
     fi
     if [ -f $cell_type_bam_path_w_bam ]; then 
         sc_bam_path_list+=" ${cell_type_bam_path_w_bam}" 
     fi
   done
   echo $combined_bam_name_rep1
   samtools merge -@ 8 -u -o $combined_bam_path$combined_bam_name_rep1 $sc_bam_path_list
   echo "done rep1"
   #empty the list
   sc_bam_path_list=()
   for idx in $(seq $(($end_idx/2 +1)) $end_idx)
   do
     cell_id_path=/project/scATAC_analysis/Corces2018_BM_FACS_scATAC/ENCODE_v3_preprocessed/$cell_type/${cell_type}_$idx
     cell_type_atac_path=/project/scATAC_analysis/Corces2018_BM_FACS_scATAC/ENCODE_v3_preprocessed/$cell_type/${cell_type}_${idx}/atac
     cell_type_bam_path=/project/scATAC_analysis/Corces2018_BM_FACS_scATAC/ENCODE_v3_preprocessed/$cell_type/${cell_type}_${idx}/atac/*/call-filter/shard-0/execution/
     # check if the path exist
     if [ -d $cell_type_bam_path ]; then 
         bam=$(ls ${cell_type_bam_path} | grep '\.bam$') 
         cell_type_bam_path_w_bam=${cell_type_bam_path}$bam
     fi
     if [ -f $cell_type_bam_path_w_bam ]; then 
         sc_bam_path_list+=" ${cell_type_bam_path_w_bam}" 
     fi
   done
   echo $combined_bam_name_rep2
   samtools merge -@ 8 -u -o $combined_bam_path$combined_bam_name_rep2 $sc_bam_path_list
   echo "done rep2"
done

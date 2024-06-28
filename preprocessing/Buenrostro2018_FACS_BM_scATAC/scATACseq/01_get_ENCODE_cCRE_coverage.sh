for cell_type in CMP HSC GMP MEP MPP CLP LMPP 
do
  cell_type_path=/project/scATAC_analysis/Corces2018_BM_FACS_scATAC/ENCODE_v3_preprocessed/$cell_type/
  end_idx=$(ls -1 ${cell_type_path} | wc -l) 
  for idx in $(seq 0 ${end_idx})
   do
     cell_id_path=/project/scATAC_analysis/Corces2018_BM_FACS_scATAC/ENCODE_v3_preprocessed/$cell_type/${cell_type}_$idx
     cell_type_atac_path=/project/scATAC_analysis/Corces2018_BM_FACS_scATAC/ENCODE_v3_preprocessed/$cell_type/${cell_type}_${idx}/atac
     cell_type_bam_path=/project/scATAC_analysis/Corces2018_BM_FACS_scATAC/ENCODE_v3_preprocessed/$cell_type/${cell_type}_${idx}/atac/*/call-filter/shard-0/execution/
     bam=$(ls ${cell_type_bam_path} | grep '\.bam$')
     cell_type_bam_path_w_bam=${cell_type_bam_path}/$bam
     filename=$(basename -- $bam)
     filename="${filename%.*}"
     SRR="${filename%%_*}"
     new_name=${cell_type}_${idx}_$SRR
     echo $new_name
     echo $SRR
     echo $cell_type_bam_path_w_bam
     bed_path="/project/scATAC_analysis/Corces2018_BM_FACS_scATAC/cCRE_coverage_of_ENCODE_v3_processed/bam_to_bed/"
     coverage_path="../../../data/Buenrostro2018_FACS_BM_scATAC/scATACseq/01_ENCODE_cCRE_coverage/"
     cd $bed_path
     samtools view -bf 0x2 ${cell_type_bam_path_w_bam} | bedtools bamtobed -i stdin > $new_name.bed
     cd $coverage_path
     bedtools coverage -a ../../../data/ENCODE_cCREs/V2.hg38-cCREs-Final_sorted.bed -b ${bed_path}${new_name}.bed> ${new_name}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
     echo $pp
   done
done
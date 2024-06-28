cell_type_path="/project/scATAC_analysis/Corces2018_BM_FACS_scATAC/analysis/get_pseudobulk_as_combined_scs/2replicates_per_cellType/combined_bam_files"
for bam_ in $cell_type_path/*.bam
do
    filename=$(basename -- $bam_)      
    filename="${filename%.*}"
    cell_type_name="${filename%%_*}"
    #new_name=${cell_type_name}_combined
    bed_path="/project/scATAC_analysis/Corces2018_BM_FACS_scATAC/analysis/get_pseudobulk_as_combined_scs/2replicates_per_cellType/cCRE_coverage/bam_to_bed/"
    coverage_path="../../../data/Buenrostro2018_FACS_BM_scATAC/feasibility_study_synthetic_prototypes/01_synthetic_prototypes_ENCODE_cCRE_coverage/"
    cd $bed_path
    samtools view -bf 0x2 ${bam_} | bedtools bamtobed -i stdin > $filename.bed
    cd $coverage_path
    bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b ${bed_path}${filename}.bed> ${filename}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
    new_name_6col=${filename}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
    cat ${filename}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' > ${new_name_6col}
done

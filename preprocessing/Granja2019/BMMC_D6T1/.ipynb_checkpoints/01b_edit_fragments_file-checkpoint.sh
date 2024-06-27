cd /project/scATAC_analysis/scATAcat_review/data/Granja2019/BMMC_D6T1/01_prepare_fragments_file/

## remove chrM

sed '/^chrM/d' GSM4138889_scATAC_BMMC_D6T1_liftOverhg38_fragments.tsv > GSM4138889_scATAC_BMMC_D6T1_liftOverhg38_no_chrMt_fragments.bed

# sort
sort -k 1,1 -k2,2n GSM4138889_scATAC_BMMC_D6T1_liftOverhg38_no_chrMt_fragments.bed > GSM4138889_scATAC_BMMC_D6T1_liftOverhg38_no_chrMt_sorted_fragments.bed
# bgzip and tabix
mkdir final_fragment_files
scp GSM4138889_scATAC_BMMC_D6T1_liftOverhg38_no_chrMt_sorted_fragments.bed ./final_fragment_files/GSM4138889_scATAC_BMMC_D6T1_liftOverhg38_no_chrMt_sorted_fragments.tsv
cd final_fragment_files
bgzip -k GSM4138889_scATAC_BMMC_D6T1_liftOverhg38_no_chrMt_sorted_fragments.tsv
tabix -p bed GSM4138889_scATAC_BMMC_D6T1_liftOverhg38_no_chrMt_sorted_fragments.tsv.gz

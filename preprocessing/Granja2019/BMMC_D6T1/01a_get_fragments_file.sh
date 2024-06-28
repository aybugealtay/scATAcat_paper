# 1. get the fragments file
# cd /project/scATAC_analysis/scATAcat_review/data/Granja2019/BMMC_D6T1/01_prepare_fragments_file
#wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM4138nnn/GSM4138889/suppl/GSM4138889%5FscATAC%5FBMMC%5FD6T1%2Efragments%2Etsv%2Egz
# 2. liftover the fragments file from hg19 to hg38 
/project/scATAC_analysis/programs/LiftOver/liftOver /project/scATAC_analysis/scATAcat_review/data/Granja2019/BMMC_D6T1/01_prepare_fragments_file/GSM4138889_scATAC_BMMC_D6T1.fragments.tsv.gz /project/scATAC_analysis/programs/LiftOver/hg19ToHg38.over.chain /project/scATAC_analysis/scATAcat_review/data/Granja2019/BMMC_D6T1/01_prepare_fragments_file/GSM4138889_scATAC_BMMC_D6T1_liftOverhg38_fragments.tsv /project/scATAC_analysis/scATAcat_review/data/Granja2019/BMMC_D6T1/01_prepare_fragments_file/GSM4138889_scATAC_BMMC_D6T1_liftOverhg38_fragments_unmapped.tsv

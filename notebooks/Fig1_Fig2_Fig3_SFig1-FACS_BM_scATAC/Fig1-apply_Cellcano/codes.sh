cd /project/scATAC_analysis/scATAcat_review/benchmarking/Cellcano/apply_CD34cells/prepare_inputs/prepare_fragments_file
> wget https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM3722nnn/GSM3722029/suppl/GSM3722029%5FCD34%5FProgenitors%5FRep1%5Ffragments%2Etsv%2Egz
--2024-04-22 14:04:48--  https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM3722nnn/GSM3722029/suppl/GSM3722029%5FCD34%5FProgenitors%5FRep1%5Ffragments%2Etsv%2Egz

# unzip
> gunzip GSM3722029_CD34_Progenitors_Rep1_fragments.tsv.gz 

# liftover to hg38
> /project/scATAC_analysis/programs/LiftOver/liftOver GSM3722029_CD34_Progenitors_Rep1_fragments.tsv /project/scATAC_analysis/programs/LiftOver/hg19ToHg38.over.chain GSM3722029_CD34_Progenitors_Rep1_liftOverhg38_fragments.tsv GSM3722029_CD34_Progenitors_Rep1_liftOverhg38_fragments_unmapped.tsv

# sort
> bedtools sort -i GSM3722029_CD34_Progenitors_Rep1_fragments.tsv > GSM3722029_CD34_Progenitors_Rep1_sorted_fragments.tsv

# bgzip
> bgzip GSM3722029_CD34_Progenitors_Rep1_sorted_fragments.tsv -@ 10

# copy data to the trrain folder
> scp GSM3722029_CD34_Progenitors_Rep1_sorted_fragments.tsv.gz ../../train_data_GSM3722029_CD34_Progenitors_Rep1/
> cd ../../train_data_GSM3722029_CD34_Progenitors_Rep1/
#tabix
>tabix -p bed GSM3722029_CD34_Progenitors_Rep1_sorted_fragments.tsv.gz 
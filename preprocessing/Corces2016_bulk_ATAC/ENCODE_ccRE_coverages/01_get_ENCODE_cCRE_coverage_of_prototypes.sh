#HSC
cd /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/ENCODE_cCRE_coverage/HSC
for i in /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/HSC/atac/251ae391-8c8d-4d86-97c4-cf339d187331/call-filter/shard-0/execution/SRR2920466_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/HSC/atac/251ae391-8c8d-4d86-97c4-cf339d187331/call-filter/shard-1/execution/SRR2920477_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/HSC/atac/251ae391-8c8d-4d86-97c4-cf339d187331/call-filter/shard-2/execution/SRR2920478_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/HSC/atac/251ae391-8c8d-4d86-97c4-cf339d187331/call-filter/shard-3/execution/SRR2920506_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/HSC/atac/251ae391-8c8d-4d86-97c4-cf339d187331/call-filter/shard-4/execution/SRR2920507_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/HSC/atac/251ae391-8c8d-4d86-97c4-cf339d187331/call-filter/shard-5/execution/SRR2920531_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/HSC/atac/251ae391-8c8d-4d86-97c4-cf339d187331/call-filter/shard-6/execution/SRR2920532_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done


# MPP
cd /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/ENCODE_cCRE_coverage/MPP
for i in /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/MPP/atac/3d4450f7-22da-44a1-9e19-97dccc8dae14/call-filter/shard-0/execution/SRR2920467_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/MPP/atac/3d4450f7-22da-44a1-9e19-97dccc8dae14/call-filter/shard-1/execution/SRR2920479_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/MPP/atac/3d4450f7-22da-44a1-9e19-97dccc8dae14/call-filter/shard-2/execution/SRR2920509_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/MPP/atac/3d4450f7-22da-44a1-9e19-97dccc8dae14/call-filter/shard-3/execution/SRR2920510_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/MPP/atac/3d4450f7-22da-44a1-9e19-97dccc8dae14/call-filter/shard-4/execution/SRR2920533_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/MPP/atac/3d4450f7-22da-44a1-9e19-97dccc8dae14/call-filter/shard-5/execution/SRR2920534_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done

# Mono
cd /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/ENCODE_cCRE_coverage/Mono
for i in /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Mono/atac/bf31ec47-252c-4e42-bda2-fae4f6dc6cab/call-filter/shard-0/execution/SRR2920475_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Mono/atac/bf31ec47-252c-4e42-bda2-fae4f6dc6cab/call-filter/shard-1/execution/SRR2920476_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Mono/atac/bf31ec47-252c-4e42-bda2-fae4f6dc6cab/call-filter/shard-2/execution/SRR2920487_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Mono/atac/bf31ec47-252c-4e42-bda2-fae4f6dc6cab/call-filter/shard-3/execution/SRR2920488_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Mono/atac/bf31ec47-252c-4e42-bda2-fae4f6dc6cab/call-filter/shard-4/execution/SRR2920542_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Mono/atac/bf31ec47-252c-4e42-bda2-fae4f6dc6cab/call-filter/shard-5/execution/SRR2920543_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done


# NKcell
cd /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/ENCODE_cCRE_coverage/NKcell
for i in /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/NKcell/atac/da919b8b-7e98-43f5-bbc7-c6c14fd50f04/call-filter/shard-0/execution/SRR2920495_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/NKcell/atac/da919b8b-7e98-43f5-bbc7-c6c14fd50f04/call-filter/shard-1/execution/SRR2920511_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/NKcell/atac/da919b8b-7e98-43f5-bbc7-c6c14fd50f04/call-filter/shard-2/execution/SRR2920512_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/NKcell/atac/da919b8b-7e98-43f5-bbc7-c6c14fd50f04/call-filter/shard-3/execution/SRR2920516_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/NKcell/atac/da919b8b-7e98-43f5-bbc7-c6c14fd50f04/call-filter/shard-4/execution/SRR2920526_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/NKcell/atac/da919b8b-7e98-43f5-bbc7-c6c14fd50f04/call-filter/shard-5/execution/SRR2920527_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done


# MEP
cd /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/ENCODE_cCRE_coverage/MEP
for i in /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/MEP/atac/339d7394-96fd-47c3-81bf-f9615444dbf8/call-filter/shard-0/execution/SRR2920473_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/MEP/atac/339d7394-96fd-47c3-81bf-f9615444dbf8/call-filter/shard-1/execution/SRR2920474_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/MEP/atac/339d7394-96fd-47c3-81bf-f9615444dbf8/call-filter/shard-2/execution/SRR2920485_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/MEP/atac/339d7394-96fd-47c3-81bf-f9615444dbf8/call-filter/shard-3/execution/SRR2920486_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/MEP/atac/339d7394-96fd-47c3-81bf-f9615444dbf8/call-filter/shard-4/execution/SRR2920508_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/MEP/atac/339d7394-96fd-47c3-81bf-f9615444dbf8/call-filter/shard-5/execution/SRR2920540_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/MEP/atac/339d7394-96fd-47c3-81bf-f9615444dbf8/call-filter/shard-6/execution/SRR2920541_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done


#CD8Tcell

cd /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/ENCODE_cCRE_coverage/CD8Tcell
for i in /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CD8Tcell/atac/a60a2fd4-712c-4bac-95a9-ccf5a2bd53e5/call-filter/shard-0/execution/SRR2920494_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CD8Tcell/atac/a60a2fd4-712c-4bac-95a9-ccf5a2bd53e5/call-filter/shard-1/execution/SRR2920497_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CD8Tcell/atac/a60a2fd4-712c-4bac-95a9-ccf5a2bd53e5/call-filter/shard-2/execution/SRR2920515_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CD8Tcell/atac/a60a2fd4-712c-4bac-95a9-ccf5a2bd53e5/call-filter/shard-3/execution/SRR2920520_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CD8Tcell/atac/a60a2fd4-712c-4bac-95a9-ccf5a2bd53e5/call-filter/shard-4/execution/SRR2920521_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done


# CD4Tcell
cd /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/ENCODE_cCRE_coverage/CD4Tcell
for i in /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CD4Tcell/atac/aaead0dc-374c-4a33-b443-e7bd45c3b3b6/call-filter/shard-0/execution/SRR2920493_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CD4Tcell/atac/aaead0dc-374c-4a33-b443-e7bd45c3b3b6/call-filter/shard-1/execution/SRR2920496_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CD4Tcell/atac/aaead0dc-374c-4a33-b443-e7bd45c3b3b6/call-filter/shard-2/execution/SRR2920514_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CD4Tcell/atac/aaead0dc-374c-4a33-b443-e7bd45c3b3b6/call-filter/shard-3/execution/SRR2920518_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CD4Tcell/atac/aaead0dc-374c-4a33-b443-e7bd45c3b3b6/call-filter/shard-4/execution/SRR2920519_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done



#Ery
cd /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/ENCODE_cCRE_coverage/Ery
for i in /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Ery/atac/30c40953-158a-4029-83dd-b3902a172e43/call-filter/shard-0/execution/SRR2920502_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Ery/atac/30c40953-158a-4029-83dd-b3902a172e43/call-filter/shard-1/execution/SRR2920503_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Ery/atac/30c40953-158a-4029-83dd-b3902a172e43/call-filter/shard-2/execution/SRR2920504_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Ery/atac/30c40953-158a-4029-83dd-b3902a172e43/call-filter/shard-3/execution/SRR2920523_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Ery/atac/30c40953-158a-4029-83dd-b3902a172e43/call-filter/shard-4/execution/SRR2920524_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Ery/atac/30c40953-158a-4029-83dd-b3902a172e43/call-filter/shard-5/execution/SRR2920525_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Ery/atac/30c40953-158a-4029-83dd-b3902a172e43/call-filter/shard-6/execution/SRR2920529_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Ery/atac/30c40953-158a-4029-83dd-b3902a172e43/call-filter/shard-7/execution/SRR2920530_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done

# GMP
cd /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/ENCODE_cCRE_coverage/GMP
for i in /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/GMP/atac/cad03ca0-a5cf-4632-9640-f56baacd2f7c/call-filter/shard-0/execution/SRR2920471_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/GMP/atac/cad03ca0-a5cf-4632-9640-f56baacd2f7c/call-filter/shard-1/execution/SRR2920472_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/GMP/atac/cad03ca0-a5cf-4632-9640-f56baacd2f7c/call-filter/shard-2/execution/SRR2920483_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/GMP/atac/cad03ca0-a5cf-4632-9640-f56baacd2f7c/call-filter/shard-3/execution/SRR2920484_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/GMP/atac/cad03ca0-a5cf-4632-9640-f56baacd2f7c/call-filter/shard-4/execution/SRR2920505_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/GMP/atac/cad03ca0-a5cf-4632-9640-f56baacd2f7c/call-filter/shard-5/execution/SRR2920538_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/GMP/atac/cad03ca0-a5cf-4632-9640-f56baacd2f7c/call-filter/shard-6/execution/SRR2920539_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done



#CMP
cd /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/ENCODE_cCRE_coverage/CMP
for i in /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CMP/atac/613e8363-5bd1-40cb-9e31-0f87f71d5fad/call-filter/shard-0/execution/SRR2920469_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CMP/atac/613e8363-5bd1-40cb-9e31-0f87f71d5fad/call-filter/shard-1/execution/SRR2920470_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CMP/atac/613e8363-5bd1-40cb-9e31-0f87f71d5fad/call-filter/shard-2/execution/SRR2920481_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CMP/atac/613e8363-5bd1-40cb-9e31-0f87f71d5fad/call-filter/shard-3/execution/SRR2920482_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CMP/atac/613e8363-5bd1-40cb-9e31-0f87f71d5fad/call-filter/shard-4/execution/SRR2920500_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CMP/atac/613e8363-5bd1-40cb-9e31-0f87f71d5fad/call-filter/shard-5/execution/SRR2920501_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CMP/atac/613e8363-5bd1-40cb-9e31-0f87f71d5fad/call-filter/shard-6/execution/SRR2920536_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CMP/atac/613e8363-5bd1-40cb-9e31-0f87f71d5fad/call-filter/shard-7/execution/SRR2920537_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done


# LMPP
cd /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/ENCODE_cCRE_coverage/LMPP
for i in /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/LMPP/atac/ae1fa3b8-afce-408e-bc58-6268bbe56925/call-filter/shard-0/execution/SRR2920468_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/LMPP/atac/ae1fa3b8-afce-408e-bc58-6268bbe56925/call-filter/shard-1/execution/SRR2920480_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/LMPP/atac/ae1fa3b8-afce-408e-bc58-6268bbe56925/call-filter/shard-2/execution/SRR2920535_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done


#CD34 Cord Blood
cd /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/ENCODE_cCRE_coverage/CD34_Cord_Blood
for i in /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CD34_Cord_Blood/atac/297aad4e-1e05-4e69-93a9-bb66adfa6f9f/call-filter/shard-0/execution/SRR2920491_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done


# CD34 Bone Marrow

cd /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/ENCODE_cCRE_coverage/CD34_Bone_Marrow
for i in /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CD34_Bone_Marrow/atac/d2bb0d7a-c873-4bb3-ae95-8370b18937bc/call-filter/shard-0/execution/SRR2920489_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CD34_Bone_Marrow/atac/d2bb0d7a-c873-4bb3-ae95-8370b18937bc/call-filter/shard-1/execution/SRR2920490_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done


#Bcell
cd /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/ENCODE_cCRE_coverage/Bcell
for i in /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Bcell/atac/c3305399-347a-4f14-871d-696a4b7bd760/call-filter/shard-0/execution/SRR2920492_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Bcell/atac/c3305399-347a-4f14-871d-696a4b7bd760/call-filter/shard-1/execution/SRR2920513_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Bcell/atac/c3305399-347a-4f14-871d-696a4b7bd760/call-filter/shard-2/execution/SRR2920517_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/Bcell/atac/c3305399-347a-4f14-871d-696a4b7bd760/call-filter/shard-3/execution/SRR2920544_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done




#CLP
cd /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/ENCODE_cCRE_coverage/HSC
for i in /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CLP/atac/b23907d7-d482-43e3-bd25-17d752d35769/call-filter/shard-0/execution/SRR2920498_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CLP/atac/b23907d7-d482-43e3-bd25-17d752d35769/call-filter/shard-1/execution/SRR2920499_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CLP/atac/b23907d7-d482-43e3-bd25-17d752d35769/call-filter/shard-2/execution/SRR2920522_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CLP/atac/b23907d7-d482-43e3-bd25-17d752d35769/call-filter/shard-3/execution/SRR2920528_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/bulk_ATAC_data/GSE74912_Corces2016/GSE74912_Corces2016_ENCODE_v3_processed/CLP/atac/b23907d7-d482-43e3-bd25-17d752d35769/call-filter/shard-4/execution/SRR2920545_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done

#pDC
cd /project/scATAC_analysis/Calderon2019_data/ENCODE_cCRE_coverage/pDC
for i in /project/scATAC_analysis/Calderon2019_data/bulk_ATAC_GSE118189_prcd_w_ENCODEpipeline/pDCs/atac/5b55dc7f-f49c-495f-8b6d-ea6c8ed108ac/call-filter/shard-0/execution/SRR7650770_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/Calderon2019_data/bulk_ATAC_GSE118189_prcd_w_ENCODEpipeline/pDCs/atac/5b55dc7f-f49c-495f-8b6d-ea6c8ed108ac/call-filter/shard-1/execution/SRR7650811_1.fastq.trim.srt.nodup.no_chrM_MT.bam /project/scATAC_analysis/Calderon2019_data/bulk_ATAC_GSE118189_prcd_w_ENCODEpipeline/pDCs/atac/5b55dc7f-f49c-495f-8b6d-ea6c8ed108ac/call-filter/shard-2/execution/SRR7650916_1.fastq.trim.srt.nodup.no_chrM_MT.bam
do
  filename=$(basename -- $i)
  filename="${filename%.*}"
  SRR="${filename%%_*}"
  samtools view -bf 0x2 $i | bedtools bamtobed -i stdin > $SRR.bed
  bedtools coverage -a /project/scATAC_analysis/10X_PBMC_analysis/AnnotationQuestion/overlap_bulk_and_scATAC/ENCODE_PBMC_cCRE/V2.hg38-cCREs-Final_sorted.bed -b $SRR.bed> ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed
  out_name=${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage_6col.bed
  DIR_="/project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/Corces2016_bulk_ATAC/ENCODE_coverages/"
  current_directory=$(basename "$(pwd)")
  DIR=$DIR_$current_directory
  mkdir $DIR
  cat ${SRR}_NOTmerged_scATAC_overlap_ENCODE_cCRE_coverage.bed | awk 'BEGIN {OFS="\t"}; {print($1,$2,$3,$4,$7, ".")}' >  $DIR/${out_name}
done
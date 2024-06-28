#!/bin/bash

IFS=$'\n'

OUTDIR="/project/scATAC_analysis/scATAcat_review/data/Zhu2023_brain_scmultiome/00_mapping"
REFDIR="/project/genomes/10xgenomics/refdata-cellranger-atac/refdata-cellranger-arc-GRCh38-2020-A-2.0.0"
# echo "Usage: $0 <SAMPLE_NAME> <REF_TRANSCRIP_FOLDER> <LIBRARIEScsv> <WHERE_TO_WRITE_RESULTS>"
mxqsub -N map_brain --tmpdir 501G --stdout=./cluster_msgs --stderr=./cluster_msgs_err --threads=10 --memory=500G --runtime=10h ./cluster_arc_cellranger.sh Zhu2023_brain_adult1 $REFDIR /project/scATAC_analysis/scATAcat_review/data/Zhu2023_brain_scmultiome/libraries.csv $OUTDIR


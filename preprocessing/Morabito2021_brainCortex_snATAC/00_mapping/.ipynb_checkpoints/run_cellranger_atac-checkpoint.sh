#!/bin/bash

IFS=$'\n'

OUTDIR="/project/scATAC_analysis/scATAcat_review/data/Morabito2021_brainCortex_snATAC/00_mapping"

REFDIR="/project/genomes/10xgenomics/refdata-cellranger-atac/refdata-cellranger-arc-GRCh38-2020-A-2.0.0"

#v $0 <SAMPLE_NAME> <REF_FOLDER> <FASQ_FOLDER> <WHERE_TO_WRITE_RESULTS>"

mxqsub --tmpdir 501G --stdout=./Morabito2021_err --stderr=./Morabito2021_std --threads=30 --memory=400000 --runtime=24h bash /project/scATAC_analysis/scATAcat_review/preprocessing/Morabito2021_brainCortex_snATAC/00_mapping/cellranger_atac_cluster.sh SRR14514144 $REFDIR /project/scATAC_analysis/scATAcat_review/data/Morabito2021_brainCortex_snATAC/00_fastq_split/gz/ $OUTDIR




# "Usage: $0 <SAMPLE_NAME> <REF_FOLDER> <FASQ_FOLDER> <WHERE_TO_WRITE_RESULTS>"

# mxqsub --tmpdir 501G --stdout=./cluster_msgs --stderr=./cluster_msgs_mergedRuns --threads=30 --memory=400000 --runtime=24h ./cluster_atac_cellranger.sh atac_bat_HL_S2 $REFDIR /project/zoo_data/DATA/Carollia_perspicillata/scATAC/merged_runs/mpimg_L20399-1_5-HL_S2 $OUTDIR
# mxqsub --tmpdir 501G --stdout=./cluster_msgs --stderr=./cluster_msgs_mergedRuns --threads=30 --memory=400000 --runtime=24h ./cluster_atac_cellranger.sh atac_bat_FL_S1 $REFDIR /project/zoo_data/DATA/Carollia_perspicillata/scATAC/merged_runs/mpimg_L20398-1_5-FL_S1 $OUTDIR
# mxqsub --tmpdir 501G --stdout=./cluster_msgs --stderr=./cluster_msgs_mergedRuns --threads=30 --memory=400000 --runtime=24h ./cluster_atac_cellranger.sh atac_bat_FL_S3 $REFDIR /project/zoo_data/DATA/Carollia_perspicillata/scATAC/merged_runs/mpimg_L20400-1_11-FL_S3 $OUTDIR
# mxqsub --tmpdir 501G --stdout=./cluster_msgs --stderr=./cluster_msgs_mergedRuns --threads=30 --memory=400000 --runtime=24h ./cluster_atac_cellranger.sh atac_bat_HL_S4 $REFDIR /project/zoo_data/DATA/Carollia_perspicillata/scATAC/merged_runs/mpimg_L20401-1_11-HL_S4 $OUTDIR
# mxqsub --tmpdir 501G --stdout=./cluster_msgs --stderr=./cluster_msgs_mergedRuns --threads=30 --memory=400000 --runtime=24h ./cluster_atac_cellranger.sh atac_bat_FL_S5 $REFDIR /project/zoo_data/DATA/Carollia_perspicillata/scATAC/merged_runs/mpimg_L20489-1_18-FL_S5 $OUTDIR
# mxqsub --tmpdir 501G --stdout=./cluster_msgs --stderr=./cluster_msgs_mergedRuns --threads=30 --memory=400000 --runtime=24h ./cluster_atac_cellranger.sh atac_bat_HL_S6 $REFDIR /project/zoo_data/DATA/Carollia_perspicillata/scATAC/merged_runs/mpimg_L20490-1_18-HL_S6 $OUTDIR
# mxqsub --tmpdir 501G --stdout=./cluster_msgs --stderr=./cluster_msgs_mergedRuns --threads=30 --memory=400000 --runtime=24h ./cluster_atac_cellranger.sh atac_bat_FL_S7 $REFDIR /project/zoo_data/DATA/Carollia_perspicillata/scATAC/merged_runs/mpimg_L20491-1_20-FL_S7 $OUTDIR
# mxqsub --tmpdir 501G --stdout=./cluster_msgs --stderr=./cluster_msgs_mergedRuns --threads=30 --memory=400000 --runtime=24h ./cluster_atac_cellranger.sh atac_bat_HL_S8 $REFDIR /project/zoo_data/DATA/Carollia_perspicillata/scATAC/merged_runs/mpimg_L20492-1_20-HL_S8 $OUTDIR

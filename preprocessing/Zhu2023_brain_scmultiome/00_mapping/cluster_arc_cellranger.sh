#! /usr/bin/bash

if [ $# -eq 4 ]; then
	SAMPLE="$1"
	TRANSCRIPTOME="$2"
	LIBRARIEScsv="$3"
	OUTFOLDER="$4"
else
	echo "Usage: $0 <SAMPLE_NAME> <REF_TRANSCRIP_FOLDER> <LIBRARIEScsv> <WHERE_TO_WRITE_RESULTS>"
	exit
fi

# set -ve

# ORIGDIR="$(/bin/pwd)"

# cp -ar $FASQ_DIR/ $MXQ_JOB_TMPDIR/
echo $MXQ_JOB_TMPDIR
cd $MXQ_JOB_TMPDIR

# FASTQ_SET=$(ls)

# echo $FASTQ_SET

## init profile just once
if [ -z "$TX_HOME" ] ; then
	source /project/scATAC_analysis/10X_software/CellRanger_profile/profile.cellrnager-arc.2.0.1
fi

DATE=$(date +%Y-%m-%d)
THREADS=20
MEM=200

cellranger-arc count \
	--id=cr_count_${SAMPLE}_${DATE} \
	--libraries=${LIBRARIEScsv} \
	--reference=${TRANSCRIPTOME} \
	--localcores=${THREADS} \
	--localmem=${MEM} \


RESULT=$(ls | grep "cr_count")

cp -r $MXQ_JOB_TMPDIR/$RESULT $OUTFOLDER/


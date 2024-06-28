#! /usr/bin/bash

if [ $# -eq 4 ]; then
	SAMPLE="$1"
	REFERENCE="$2"
	FASQ_DIR="$3"
	OUTFOLDER="$4"
else
	echo "Usage: $0 <SAMPLE_NAME> <REF_FOLDER> <FASQ_FOLDER> <WHERE_TO_WRITE_RESULTS>"
	exit
fi

set -ve

ORIGDIR="$(/bin/pwd)"

#cp -ar $FASQ_DIR/*.gz $MXQ_JOB_TMPDIR/
FOLDER_NAME=$(basename ${FASQ_DIR})
cd $MXQ_JOB_TMPDIR
mkdir $FOLDER_NAME

cp -ar $FASQ_DIR/*.gz $MXQ_JOB_TMPDIR/$FOLDER_NAME/

FASTQ_SET=$(ls)

echo $FASTQ_SET

## init profile just once
if [ -z "$TX_HOME" ] ; then
	source /project/synhance/code/scatac/10X_prerequisites/profile.cellranger.atac-2.1.0
fi

DATE=$(date +%Y-%m-%d)
THREADS=20
MEM=300

cellranger-atac count \
	--id=cr_count_${SAMPLE}_${DATE} \
	--fastqs=${MXQ_JOB_TMPDIR}/${FASTQ_SET} \
	--reference=${REFERENCE} \
	--sample=${SAMPLE} \
	--localcores=${THREADS} \
	--localmem=${MEM} \
	--disable-ui

RESULT=$(ls | grep "cr_count")

cp -r $MXQ_JOB_TMPDIR/$RESULT $OUTFOLDER/
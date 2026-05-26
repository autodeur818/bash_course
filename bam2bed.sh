#!/bin/bash

#defining the inputs
INPUT_BAM="$1"
OUTPUT_DIR="$2"

BAM_FILENAME=$(basename "$INPUT_BAM")
BED_FILENAME="${BAM_FILENAME%.bam}.bed"
CHR_FILTER="${BAM_FILENAME%.bam}_chr1.bed"

echo "Input Bam: $INPUT_BAM"
echo "Output directory: $OUTPUT_DIR"

#create the directory
mkdir -p "$OUTPUT_DIR"
echo "Output directory created"

#create and activate conda environment
source $(dirname $(dirname $(which mamba)))/etc/profile.d/conda.sh
conda create -n bam2bed bedtools
conda activate bam2bed
echo "Environment activated successfully."

#transform BAM into BED
bedtools bamtobed -i "$INPUT_BAM" > "$OUTPUT_DIR/$BED_FILENAME"
echo "transforming bam into bed..."

#filter for chr1
grep -P  "^Chr1\t" "$OUTPUT_DIR/$BED_FILENAME" > "$OUTPUT_DIR/$CHR_FILTER"
echo "filtering bed file for chr1..."

#count the number of lines
wc -l "$OUTPUT_DIR/$CHR_FILTER" > "$OUTPUT_DIR/bam2bed_number_of_rows.txt"
echo "number of lines is counted..."

#print name
echo "Jochem van Tol"



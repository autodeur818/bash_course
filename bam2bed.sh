#!/bin/bash

#defining the objects to improve readability
INPUT_BAM = "$1"
OUTPUT_DIR = "$2"

#create the new output directory
mkdir -p "$OUTPUT_DIR"

source $(dirname $(dirname $(which mamba)))/etc/profile.d/conda.sh

#create and activate bam2bed environment
conda create -y -n bam2bed bedtools
conda activate bam2bed

#convert BAM to bed file and save in output directory
OUTPUT_FILE=$(basename ${INPUT_BAM}.bam)
echo $OUTPUT_FILE
bedtools bamtobed -i "$INPUT_BAM" > "$OUTPUT_DIR/$(basename "$INPUT_BAM" .bam).bed"

#filter bed file only for chr1 and save as new bed file
grep -i -w "chr1" "$OUTPUT_DIR/$OUTPUT_FILE.bed" > "$OUTPUT_DIR/$OUTPUT_FILE""_chr1.bed"

#count number of lines in filtered bed file
#wc -l "$2/$(basename "$1" .bam)_chr1.bed" | awk '{print $1}'  > "$2/bam2bed_number_of_rows.txt"
wc -l "$OUTPUT_DIR/$OUTPUT_FILE""_chr1.bed" > "$OUTPUT_DIR/bam2bed_number_of_rows.txt"
echo "Count file:"$OUTPUT_DIR"/bam2bed_number_of_rows.txt"

#print my name
echo "Jochem van Tol"

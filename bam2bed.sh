#!/bin/bash

#defining the objects to improve readability
INPUT_BAM = "$1"
OUTPUT_DIR = "$2"

#create the new output directory
mkdir -p "$OUTPUT_DIR"

#access conda,
source $(dirname $(dirname $(which mamba)))/etc/profile.d/conda.sh

#create and activate bam2bed environment
mamba create -n bam2bed -c conda-forge bedtools -y
conda activate bam2bed


#installing bedtools package
conda install bedtools

#convert BAM to bed file and save in output directory
bedtools bamtobed -i "$1" > "$2/$(basename "$1" .bam).bed"

#filter bed file only for chr1 and save as new bed file
grep -P "^\s*Chr1\s" "$2/$(basename "$1" .bam).bed" > "$2/$(basename "$1" .bam)_chr1.bed"

#count number of lines in filtered bed file
#wc -l "$2/$(basename "$1" .bam)_chr1.bed" | awk '{print $1}'  > "$2/bam2bed_number_of_rows.txt"
echo "$(wc -l < "$2/$(basename "$1" .bam)_chr1.bed") $2/$(basename "$1" .bam)_chr1.bed" > "$2/bam2bed_number_of_rows.txt"

#print my name
echo "Jochem van Tol"

#!/bin/bash
query="$1"
subject="$2"
output="$3"

makeblastdb -in "$subject" -dbtype nucl -out subject_db > /dev/null 2>&1

tblastn -query "$query" -db subject_db \
       -outfmt "6 qseqid sseqid pident length qlen bitscore" \
        | awk -F'\t' '$5>0 && ($3>30) && ($4/$5>0.9)' > "$output"

wc -l < "$output"

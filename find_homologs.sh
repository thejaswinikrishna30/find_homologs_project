#!/bin/bash

query="$1"
subject="$2"
output="$3"

makeblastdb -in "$subject" -dbtype prot -out subject_db

blastx -query "$query" -db subject_db \
       -outfmt "6 pident length qlen bitscore" \
       -out temp_blast_results.txt

awk '{
    coverage = $2 / $3 * 100    # $2 = alignment length, $3 = query length
    if ($1 >= 30 && coverage >= 90) print
}' temp_blast_results.txt > filtered_results.txt

num_hits=$(wc -l < "$output")
echo "No. of hits: $num_hits"

rm temp_blast_results.txt

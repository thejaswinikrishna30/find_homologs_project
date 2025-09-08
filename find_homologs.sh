#!/bin/bash
query="$1"
subject="$2"
makeblastdb -in "$subject" -dbtype nucl -out subject_db
tblastn -query "$query" -db subject_db \
       -outfmt "6 qseqid sseqid pident length evalue bitscore" \
  | awk -F'\t' '($3 > 30) && ($4 > 0)' \
  | grep -c .


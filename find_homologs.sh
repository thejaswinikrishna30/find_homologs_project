  GNU nano 7.2                  find_homologs.sh                            #!/bin/bash
query="$1"
subject="$2"
output="$3"
makeblastdb -in "$subject" -dbtype prot -out subject_db
blastx -query "$query" -db subject_db \
       -outfmt "6 qseqid sseqid pident length evalue bitscore" \
       | awk -F'\t' '$5>0 && ($3>30) && ($4/$5>0.9)' > "$output"
num_hits=$(wc -l < "$output")
echo "$num_hits"



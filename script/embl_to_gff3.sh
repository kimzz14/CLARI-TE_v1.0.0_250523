#!/bin/bash

###### embl2gff: takes all chunks embl and produces one merged .gff per chrom
## NB: script embl2gff.pl gives an ID per TE per chrom (not per chunk) from zero if a list of ordered files for all chunks is given for each chrom
## That is why an embl_files list is created before

embl_files=$(cat result/${1}/${1}_embl_list)

#option -note: Convert all tags/values to a single tag Note="tag:xxx; tag:xxx; tag:xxx"
#option -l <interger>: Length threshold to skip small features [default: 1 bp]
./script/embl2gff.pl -RMclariTE -featurePrefix $2 -source clariTE -note -l 10 ${embl_files} > result/${1}/${1}_clariTE.gff

###### gff to gff3: new coordinates calculation with gawk commands "match" + "substr" (from chunks relative to chrom relative)
grep -v $'\t''region' result/${1}/${1}_clariTE.gff |grep -v '#' \
|awk -v FS='\t' -v OFS='\t' '{match($1, /:[0-9]+-/); $4=$4+substr($0, RSTART+1, RLENGTH-2); $5=$5+substr($0, RSTART+1, RLENGTH-2); print}' \
|gt gff3 -sort -tidy -retainids 1> result/${1}/${1}_clariTE_tmp.gff3  2> result/${1}/${1}_clariTE_tmp_gt.log

### variable $endchrom to give the right sequence-region coordinate in gff3
endchrom=$(grep ${1} result/ref.fa.fai |cut -f2)

# grep -v command keeps only one "sequence-region" line starting with zero coordinate
# gawk and sed commands to format in a more friendly way
grep -v -P '##sequence-region *'$1':[1-9]' result/${1}/${1}_clariTE_tmp.gff3 \
|awk -v LG=$1 -v end=$endchrom 'BEGIN{FS="\t";OFS="\t"} { if ($0~"##sequence-region") $0="##sequence-region\t"LG"\t1\t"end; print }' \
|sed -E 's/'$1':[0-9]*-[0-9]*/'$1'/' |sed -E 's/Compo:.* (Family)/\1/' | sed -E 's/Post:.* (Status)/\1/' > result/${1}/${1}_clariTE.gff3

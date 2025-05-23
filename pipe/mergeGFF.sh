########################################################################################
#${threadN} ${TeIDsPrefix} ${chroms}
threadN=$1
TeIDsPrefix=$2
chroms=$3

########################################################################################

for chrom in "${chroms[@]}"; do
    ls -1 result/${chrom}/split/*/*.fa_annoTE.embl | sort -t ':' -k2,2n |tr -s '\n' ' ' >  result/${chrom}/${chrom}_embl_list
    ./script/embl_to_gff3.sh ${chrom} ${TeIDsPrefix} &
done
wait

#input_gff
input_gff=""
for chrom in "${chroms[@]}"; do
    input_gff+="result/${chrom}/${chrom}_clariTE.gff3 "
done

gt gff3 -sort -tidy -retainids ${input_gff} 1> result/${TeIDsPrefix}.clariTE.gff3 2> result/${TeIDsPrefix}.gt_gff3_tidy.err

########################################################################################
#${threadN} ${TeIDsPrefix} ${chroms}
threadN=$1
chroms=$3
########################################################################################
for chrom in "${chroms[@]}"; do
    while read -r line; do
        prefix=$(echo "$line" | awk '{print $1}')

        sed -i 's/#Unspecified/#Unknown/' result/${chrom}/split/${prefix}.RM/${prefix}.fa.out.xm

        perl ./script/CLARI-TE/clariTE.pl \
            -dir result/${chrom}/split/${prefix}.RM/ \
            -LTR ./script/CLARI-TE/clariTeRep_LTRposition.txt \
            -classi ./script/CLARI-TE/clariTeRep_classification.txt \
            -fasta result/${chrom}/split/${prefix}.fa \
            result/${chrom}/split/${prefix}.RM/${prefix}.fa.out.xm \
            1> result/${chrom}/split/${prefix}.RM/clariTE.log 2>&1 &

    done < "result/${chrom}/${chrom}.windows.fa.fai"
done
wait

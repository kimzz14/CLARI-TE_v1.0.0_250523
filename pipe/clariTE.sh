########################################################################################
########################################################################################
while read -r line; do
    chrom=$(echo "$line" | awk '{print $1}')

    sed -i 's/#Unspecified/#Unknown/' result/${chrom}/${chrom}.RM/${chrom}.fa.out.xm

    perl ./script/CLARI-TE/clariTE.pl \
        -dir result/${chrom}/${chrom}.RM/ \
        -LTR ./script/CLARI-TE/clariTeRep_LTRposition.txt \
        -classi ./script/CLARI-TE/clariTeRep_classification.txt \
        -fasta result/${chrom}/${chrom}.fa \
        result/${chrom}/${chrom}.RM/${chrom}.fa.out.xm \
        1> result/${chrom}/${chrom}.RM/clariTE.log \
        2> result/${chrom}/${chrom}.RM/clariTE.err &

done < "result/ref.fa.fai"
wait
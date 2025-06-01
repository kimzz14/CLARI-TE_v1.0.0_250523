########################################################################################
threadN=128
########################################################################################
while read -r line; do
    chrom=$(echo "$line" | awk '{print $1}')

    mkdir -p result/${chrom}/${chrom}.RM
    RepeatMasker \
        -lib ./script/CLARI-TE/clariTeRep.fna \
        -xsmall \
        -nolow \
        -xm \
        -pa ${threadN}\
        -q \
        -dir result/${chrom}/${chrom}.RM \
        result/${chrom}/${chrom}.fa \
        1> result/${chrom}/${chrom}.RM/repeatmasker.log \
        2> result/${chrom}/${chrom}.RM/repeatmasker.err
done < "result/ref.fa.fai"
wait


########################################################################################
#    -pa(rallel) [number]
#    -q  Quick search; 5-10% less sensitive, 2-5 times faster than default
#    -nolow
#        Does not mask low_complexity DNA or simple repeats
#    -xsmall
#        Returns repetitive regions in lowercase (rest capitals) rather than masked
#    -xm Creates an additional output file in cross_match format (for parsing)
#    -lib [filename]
#        Allows use of a custom library (e.g. from another species)

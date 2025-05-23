########################################################################################
#${threadN} ${TeIDsPrefix} ${chroms}
threadN=$1
chroms=$3

########################################################################################
for chrom in "${chroms[@]}"; do
    mkdir -p result/${chrom}
    cd result/${chrom}

    while read -r line; do
        prefix=$(echo "$line" | awk '{print $1}')
        mkdir -p split/${prefix}.RM

        RepeatMasker \
            -lib ../../script/CLARI-TE/clariTeRep.fna \
            -xsmall \
            -nolow \
            -xm \
            -pa ${threadN}\
            -q \
            -dir split/${prefix}.RM \
            split/${prefix}.fa \
            1> split/${prefix}.RM/repeatmasker.log 2>&1 &

    done < "${chrom}.windows.fa.fai"
    cd ../..
done
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

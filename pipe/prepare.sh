########################################################################################
########################################################################################
samtools faidx result/ref.fa

while read -r line; do
    chrom=$(echo "$line" | awk '{print $1}')

    mkdir -p result/${chrom}
    samtools faidx result/ref.fa ${chrom} > result/${chrom}/${chrom}.fa &
done < "result/ref.fa.fai"
wait

while read -r line; do
    chrom=$(echo "$line" | awk '{print $1}')

    samtools faidx result/${chrom}/${chrom}.fa &
done < "result/ref.fa.fai"
wait

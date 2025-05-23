############################################################################################
#${threadN} ${TeIDsPrefix} ${chroms}
chroms=$3

############################################################################################
samtools faidx result/ref.fa
for chrom in "${chroms[@]}"; do
    mkdir -p result/${chrom}
    samtools faidx result/ref.fa ${chrom} > result/${chrom}/${chrom}.fa &
done
wait

for chrom in "${chroms[@]}"; do
    samtools faidx result/${chrom}/${chrom}.fa &
done
wait

for chrom in "${chroms[@]}"; do
    bedtools makewindows -g result/${chrom}/${chrom}.fa.fai -w 10000000 > result/${chrom}/${chrom}.windows.bed &
done
wait

for chrom in "${chroms[@]}"; do
    bedtools getfasta -bed result/${chrom}/${chrom}.windows.bed -fi result/${chrom}/${chrom}.fa > result/${chrom}/${chrom}.windows.fa &
done
wait

for chrom in "${chroms[@]}"; do
    samtools faidx result/${chrom}/${chrom}.windows.fa &
done
wait

for chrom in "${chroms[@]}"; do
    mkdir -p result/${chrom}/split
    fastaexplode  -f result/${chrom}/${chrom}.windows.fa -d result/${chrom}/split &
done
wait

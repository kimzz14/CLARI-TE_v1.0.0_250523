############################################################################################
threadN=24
TeIDsPrefix=KJH
chroms=("Chr1A" "Chr2A" "Chr3A" "Chr4A" "Chr5A" "Chr6A" "Chr7A" \
             "Chr1B" "Chr2B" "Chr3B" "Chr4B" "Chr5B" "Chr6B" "Chr7B" \
             "Chr1D" "Chr2D" "Chr3D" "Chr4D" "Chr5D" "Chr6D" "Chr7D" \
             "ChrUnknown")
chroms=("chr01" "chr02")
############################################################################################
#bash pipe/prepare.sh      ${threadN} ${TeIDsPrefix} ${chroms}
#bash pipe/repeatmasker.sh ${threadN} ${TeIDsPrefix} ${chroms}
#bash pipe/clariTE.sh      ${threadN} ${TeIDsPrefix} ${chroms}
bash pipe/mergeGFF.sh     ${threadN} ${TeIDsPrefix} ${chroms}

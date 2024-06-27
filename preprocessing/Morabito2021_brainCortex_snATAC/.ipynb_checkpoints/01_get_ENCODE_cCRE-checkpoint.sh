cd /project/scATAC_analysis/scATAcat_review/data/Morabito2021_brainCortex_snATAC/01_ENCODE_cCRE_coverage

grep -e '^chr' /project/scATAC_analysis/scATAcat_review/data/Morabito2021_brainCortex_snATAC/00_mapping/cr_count_SRR14514144_2024-05-22/outs/fragments.tsv > /project/scATAC_analysis/scATAcat_review/data/Morabito2021_brainCortex_snATAC/00_mapping/cr_count_SRR14514144_2024-05-22/outs/fragments_only_conv_chr.tsv &&
bedtools map -a /project/scATAC_analysis/scATAcat_notebooks_for_paper/jan2024/data/ENCODE_cCREs/V2.hg38-cCREs-3col_sorted.bed -b /project/scATAC_analysis/scATAcat_review/data/Morabito2021_brainCortex_snATAC/00_mapping/cr_count_SRR14514144_2024-05-22/outs/fragments_only_conv_chr.tsv -c 4,5 -o collapse > Morabito2021_brainCortex_atac_fragments_ENCORE_cCRE_regions.bed

bgzip -k /project/scATAC_analysis/scATAcat_review/data/Morabito2021_brainCortex_snATAC/00_mapping/cr_count_SRR14514144_2024-05-22/outs/fragments_only_conv_chr.tsv
tabix -p bed /project/scATAC_analysis/scATAcat_review/data/Morabito2021_brainCortex_snATAC/00_mapping/cr_count_SRR14514144_2024-05-22/outs/fragments_only_conv_chr.tsv.gz
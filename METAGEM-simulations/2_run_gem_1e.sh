#!/bin/bash

file=("ukb_100k_set1.csv" "ukb_50k_set1.csv" "ukb_50k_set2.csv" "ukb_10k_set1.csv" "ukb_10k_set2.csv" "ukb_10k_set3.csv" "ukb_10k_set4.csv" "ukb_10k_set5.csv" "ukb_10k_set6.csv" "ukb_10k_set7.csv" "ukb_Xk_set1.csv")
sets=("100k_1" "50k_1" "50k_2" "10k_1" "10k_2" "10k_3" "10k_4" "10k_5" "10k_6" "10k_7" "Xk_1")

# Run GEM on DNAnexus
for j in {6..6}
do
	for i in {2..2}
	do
		dx run run_gem_pgen --instance-type mem1_ssd1_v2_x16 --name "run_GEM_v1.5" --destination "/METAGEM-METAL-Comparisons/1-Exposure/v2/GEM/${sets[j]}/Chr${i}" -isample_id_header="id" -iphenofile="/METAGEM-METAL-Comparisons/phenotype-data/v2/${file[j]}" -ioutcome="WHR" -iexposure_names="sex" -icovar_names="BMI age age2 PC1 PC2 PC3 PC4 PC5" -ipgenfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.pgen" -ipvarfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.pvar" -ipsamfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.psam" -imaf=0.001 -irobust=1 -imissing="NA" -idelimiter="," -istream_snps=1 -ioutput_style="full" -itol=0.000001 -ithreads=8 -icpu=1 -idisk=50 -imemory=4 -ipreemptible=0 -imonitoring_freq=1 -y -icenter=0
	done
done

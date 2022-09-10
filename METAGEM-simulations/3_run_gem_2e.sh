#!/bin/bash

file=("ukb_100k_set1.csv" "ukb_50k_set1.csv" "ukb_50k_set2.csv" "ukb_10k_set1.csv" "ukb_10k_set2.csv" "ukb_10k_set3.csv" "ukb_10k_set4.csv" "ukb_10k_set5.csv" "ukb_10k_set6.csv" "ukb_10k_set7.csv" "ukb_Xk_set1.csv")
sets=("100k_1" "50k_1" "50k_2" "10k_1" "10k_2" "10k_3" "10k_4" "10k_5" "10k_6" "10k_7" "Xk_1")

# Run GEM on DNAnexus
for j in {0..10}
do

	for i in {1..22}
	do
		dx run run_tests_pgen --instance-type mem1_ssd1_v2_x8 --name "run_GEM_v1.4.1" --destination "/METAGEM-METAL-Comparisons/2-Exposures/GEM/${sets[j]}/Chr${i}" -isample_id_header="eid" -iphenofile="/METAGEM-METAL-Comparisons/phenotype-data/${file[j]}" -ioutcome="WHR" -iexposure_names="sex BMI" -icovar_names="age age2 PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10" -ipgenfile="/METAGEM-METAL-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_${sets[j]}.pgen" -ipvarfile="/METAGEM-METAL-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_${sets[j]}.pvar" -ipsamfile="/METAGEM-METAL-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_${sets[j]}.psam" -imaf=0 -irobust=1 -imissing="NA" -idelimiter="," -istream_snps=1 -ioutput_style="meta" -itol=0.0000001 -ithreads=4 -icpu=1 -idisk=50 -imemory=4 -ipreemptible=0 -imonitoring_freq=1 -y
	done
done

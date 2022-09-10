#!/bin/bash

# Initial model:
#  WHR phenotype, GxSex - GxBMI Interaction Covariate
for i in {1..22} # Chromosomes
do
	dx run run_tests_pgen --instance-type mem1_ssd1_v2_x8 --name "run_GEMv1.4.1" --destination "/GEM-REGEM-Comparisons/Results/GEMv1.4.1/sexE_bmiI/chr${i}" -icpu=1 -idelimiter=, -idisk=50 -ioutcome="WHR" -iexposure_names="sex" -iint_covar_names="BMI" -icovar_names="age age2 PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10" -iphenofile="/GEM-REGEM-Comparisons/ukb23673_UnrelatedWhiteBritish_pheno_w42646_20220222_excluded.csv" -ipgenfile="/GEM-REGEM-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_275k.pgen" -ipvarfile="/GEM-REGEM-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_275k.pvar" -ipsamfile="/GEM-REGEM-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_275k.psam" -imaf=0.0 -imemory=8 -imissing=NA -irobust=1 -isample_id_header=eid -ithreads=1 -itol=0.0000001 -istream_snps=1 -imonitoring_freq=1 -ioutput_style=full -ipreemptible=0 -y
done


#WHR phenotype, GxSex + GxBMI
for i in {1..22} # Chromosomes
do
	dx run run_tests_pgen --instance-type mem1_ssd1_v2_x8 --name "run_GEMv1.4.1" --destination "/GEM-REGEM-Comparisons/Results/GEMv1.4.1/sexE_bmiE/chr${i}/${se[j]}" -icpu=1 -idelimiter=, -idisk=50 -ioutcome="WHR" -iexposure_names="sex BMI" -icovar_names="age age2 PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10" -iphenofile="/GEM-REGEM-Comparisons/ukb23673_UnrelatedWhiteBritish_pheno_w42646_20220222_excluded.csv" -ipgenfile="/GEM-REGEM-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_275k.pgen" -ipvarfile="/GEM-REGEM-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_275k.pvar" -ipsamfile="/GEM-REGEM-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_275k.psam" -imaf=0.0 -imemory=8 -imissing=NA -irobust=1 -isample_id_header=eid -ithreads=1 -itol=0.0000001 -istream_snps=1 -imonitoring_freq=1 -ioutput_style="full" -ipreemptible=0 -y
done


#WHR phenotype, GxSex Interaction Covariate - GxBMI
for i in {1..22} # Chromosomes
do
	dx run run_tests_pgen --instance-type mem1_ssd1_v2_x8 --name "run_GEMv1.4.1" --destination "/GEM-REGEM-Comparisons/Results/GEMv1.4.1/sexI_bmiE/chr${i}/${se[j]}" -icpu=1 -idelimiter=, -idisk=50 -ioutcome="WHR" -iexposure_names="BMI" -iint_covar_names="sex" -icovar_names="age age2 PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10" -iphenofile="/GEM-REGEM-Comparisons/ukb23673_UnrelatedWhiteBritish_pheno_w42646_20220222_excluded.csv" -ipgenfile="/GEM-REGEM-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_275k.pgen" -ipvarfile="/GEM-REGEM-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_275k.pvar" -ipsamfile="/GEM-REGEM-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_275k.psam" -imaf=0.0 -imemory=8 -imissing=NA -irobust=1 -isample_id_header=eid -ithreads=1 -itol=0.0000001 -istream_snps=1 -imonitoring_freq=1 -ioutput_style="full" -ipreemptible=0 -y
done


#WHR phenotype, GxSex
for i in {1..22} # Chromosomes
do
	dx run run_tests_pgen --instance-type mem1_ssd1_v2_x8 --name "run_GEMv1.4.1" --destination "/GEM-REGEM-Comparisons/Results/GEMv1.4.1/sexE/chr${i}/${se[j]}" -icpu=1 -idelimiter=, -idisk=50 -ioutcome="WHR" -iexposure_names="sex" -icovar_names="BMI age age2 PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10" -iphenofile="/GEM-REGEM-Comparisons/ukb23673_UnrelatedWhiteBritish_pheno_w42646_20220222_excluded.csv" -ipgenfile="/GEM-REGEM-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_275k.pgen" -ipvarfile="/GEM-REGEM-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_275k.pvar" -ipsamfile="/GEM-REGEM-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_275k.psam" -imaf=0.0 -imemory=8 -imissing=NA -irobust=1 -isample_id_header=eid -ithreads=1 -itol=0.0000001 -istream_snps=1 -imonitoring_freq=1 -ioutput_style="full" -ipreemptible=0 -y
done


#WHR phenotype, GxBMI
for i in {1..22} # Chromosomes
do
	dx run run_tests_pgen --instance-type mem1_ssd1_v2_x8 --name "run_GEMv1.4.1" --destination "/GEM-REGEM-Comparisons/Results/GEMv1.4.1/bmiE/chr${i}/${se[j]}" -icpu=1 -idelimiter=, -idisk=50 -ioutcome="WHR" -iexposure_names="BMI" -icovar_names="sex age age2 PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10" -iphenofile="/GEM-REGEM-Comparisons/ukb23673_UnrelatedWhiteBritish_pheno_w42646_20220222_excluded.csv" -ipgenfile="/GEM-REGEM-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_275k.pgen" -ipvarfile="/GEM-REGEM-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_275k.pvar" -ipsamfile="/GEM-REGEM-Comparisons/genotype-data/ukb_imp_chr${i}_v3_filtered_275k.psam" -imaf=0.0 -imemory=8 -imissing=NA -irobust=1 -isample_id_header=eid -ithreads=1 -itol=0.0000001 -istream_snps=1 -imonitoring_freq=1 -ioutput_style="full" -ipreemptible=0 -y
done

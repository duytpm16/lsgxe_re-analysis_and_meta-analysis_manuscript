#!/bin/bash

# Initial model:
#  WHR phenotype, GxSex - GxBMI Interaction Covariate
for i in {1..22} # Chromosomes
do
	dx run run_tests_pgen --instance-type mem1_ssd1_v2_x8 --name "run_GEMv1.5" --destination "/GEM-REGEM-Comparisons/Results/v2/GEMv1.5/sexE_bmiI/chr${i}" -icpu=1 -idelimiter=, -idisk=50 -ioutcome="WHR" -iexposure_names="sex" -iint_covar_names="BMI" -icovar_names="age age2 PC1 PC2 PC3 PC4 PC5" -iphenofile="/GEM-REGEM-Comparisons/Results/v2/ukb672044_eur_subset.csv" -ipgenfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.pgen" -ipvarfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.pvar" -ipsamfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.psam" -imaf=0.0 -imemory=8 -imissing=NA -irobust=1 -isample_id_header=id -ithreads=1 -itol=0.000001 -istream_snps=1 -imonitoring_freq=1 -ioutput_style=full -ipreemptible=0 -y
done


#WHR phenotype, GxSex + GxBMI
for i in {1..22} # Chromosomes
do
	dx run run_tests_pgen --instance-type mem1_ssd1_v2_x8 --name "run_GEMv1.5" --destination "/GEM-REGEM-Comparisons/Results/v2/GEMv1.5/sexE_bmiE/chr${i}" -icpu=1 -idelimiter=, -idisk=50 -ioutcome="WHR" -iexposure_names="sex BMI" -icovar_names="age age2 PC1 PC2 PC3 PC4 PC5" -iphenofile="/GEM-REGEM-Comparisons/Results/v2/ukb672044_eur_subset.csv" -ipgenfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.pgen" -ipvarfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.pvar" -ipsamfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.psam" -imaf=0.0 -imemory=8 -imissing=NA -irobust=1 -isample_id_header=id -ithreads=1 -itol=0.000001 -istream_snps=1 -imonitoring_freq=1 -ioutput_style=full -ipreemptible=0 -y
done


#WHR phenotype, GxSex Interaction Covariate - GxBMI
for i in {1..22} # Chromosomes
do
	dx run run_tests_pgen --instance-type mem1_ssd1_v2_x8 --name "run_GEMv1.5" --destination "/GEM-REGEM-Comparisons/Results/v2/GEMv1.5/sexI_bmiE/chr${i}" -icpu=1 -idelimiter=, -idisk=50 -ioutcome="WHR" -iexposure_names="BMI" -iint_covar_names="sex" -icovar_names="age age2 PC1 PC2 PC3 PC4 PC5" -iphenofile="/GEM-REGEM-Comparisons/Results/v2/ukb672044_eur_subset.csv" -ipgenfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.pgen" -ipvarfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.pvar" -ipsamfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.psam" -imaf=0.0 -imemory=8 -imissing=NA -irobust=1 -isample_id_header=id -ithreads=1 -itol=0.000001 -istream_snps=1 -imonitoring_freq=1 -ioutput_style=full -ipreemptible=0 -y
done


#WHR phenotype, GxSex
for i in {1..22} # Chromosomes
do
	dx run run_tests_pgen --instance-type mem1_ssd1_v2_x8 --name "run_GEMv1.5" --destination "/GEM-REGEM-Comparisons/Results/v2/GEMv1.5/sexE/chr${i}" -icpu=1 -idelimiter=, -idisk=50 -ioutcome="WHR" -iexposure_names="sex" -icovar_names="BMI age age2 PC1 PC2 PC3 PC4 PC5" -iphenofile="/GEM-REGEM-Comparisons/Results/v2/ukb672044_eur_subset.csv" -ipgenfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.pgen" -ipvarfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.pvar" -ipsamfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.psam" -imaf=0.0 -imemory=8 -imissing=NA -irobust=1 -isample_id_header=id -ithreads=1 -itol=0.000001 -istream_snps=1 -imonitoring_freq=1 -ioutput_style=full -ipreemptible=0 -y
done


#WHR phenotype, GxBMI
for i in {1..22} # Chromosomes
do
	dx run run_tests_pgen --instance-type mem1_ssd1_v2_x8 --name "run_GEMv1.5" --destination "/GEM-REGEM-Comparisons/Results/v2/GEMv1.5/bmiE/chr${i}" -icpu=1 -idelimiter=, -idisk=50 -ioutcome="WHR" -iexposure_names="BMI" -icovar_names="sex age age2 PC1 PC2 PC3 PC4 PC5" -iphenofile="/GEM-REGEM-Comparisons/Results/v2/ukb672044_eur_subset.csv" -ipgenfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.pgen" -ipvarfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.pvar" -ipsamfile="/imp_ukb/pgen/ukb_imp_chr${i}_v3.psam" -imaf=0.0 -imemory=8 -imissing=NA -irobust=1 -isample_id_header=id -ithreads=1 -itol=0.000001 -istream_snps=1 -imonitoring_freq=1 -ioutput_style=full -ipreemptible=0 -y
done

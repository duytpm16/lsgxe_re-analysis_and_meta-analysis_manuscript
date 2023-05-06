#!/bin/bash

#WHR phenotype, GxSex
#dx run run_regem --instance-type mem1_ssd1_v2_x16 --name "run_REGEM" --destination "/GEM-REGEM-Comparisons/Results/v2/REGEM/sexE/results" -iinputfile="/GEM-REGEM-Comparisons/Results/v2/GEMv1.5/sexE_bmiI/combined/gem_sexE_bmiI_combined.out" -iexposure_names="sex" -ioutput_style="full" -icpu=1 -idisk=10 -imemory=3 -ipreemptible=0 -y


#WHR phenotype, GxBMI
#dx run run_regem --instance-type mem1_ssd1_v2_x16 --name "run_REGEM" --destination "/GEM-REGEM-Comparisons/Results/v2/REGEM/bmiE/results" -iinputfile="/GEM-REGEM-Comparisons/Results/v2/GEMv1.5/sexE_bmiI/combined/gem_sexE_bmiI_combined.out" -iexposure_names="BMI" -ioutput_style="full" -icpu=1 -idisk=10 -imemory=3 -ipreemptible=0 -y


#WHR phenotype, GxSex + GxBMI
dx run run_regem --instance-type mem1_ssd1_v2_x16 --name "run_REGEM" --destination "/GEM-REGEM-Comparisons/Results/v2/REGEM/sexE_bmiE/results" -iinputfile="/GEM-REGEM-Comparisons/Results/v2/GEMv1.5/sexE_bmiI/combined/gem_sexE_bmiI_combined.out" -iexposure_names="sex BMI" -ioutput_style="full" -icpu=1 -idisk=10 -imemory=3 -ipreemptible=0 -y


#WHR phenotype, GxSex IC, GxBMI E
#dx run run_regem --instance-type mem1_ssd1_v2_x16 --name "run_REGEM" --destination "/GEM-REGEM-Comparisons/Results/v2/REGEM/sexI_bmiE/results" -iinputfile="/GEM-REGEM-Comparisons/Results/v2/GEMv1.5/sexE_bmiI/combined/gem_sexE_bmiI_combined.out" -iexposure_names="BMI" -iint_covar_names="sex"  -ioutput_style="full" -icpu=1 -idisk=10 -imemory=3 -ipreemptible=0 -y


#!/bin/bash

sets=("sexE" "bmiE" "sexI_bmiE" "sexE_bmiE") 

#WHR phenotype, GxSex + GxBMI
dx run run_regem --instance-type mem1_ssd1_v2_x8 --name "run_REGEM" --destination "/GEM-REGEM-Comparisons/Results/REGEM/sexE/results" -iinputfile="/GEM-REGEM-Comparisons/Results/GEMv1.4.1/sexE_bmiI/combined/gem_sexE_bmiI_combined.out" -iexposure_names="sex" -ioutput_style="full" -icpu=1 -idisk=10 -imemory=3 -ipreemptible=0 -y


#WHR phenotype, GxSex + GxBMI
dx run run_regem --instance-type mem1_ssd1_v2_x8 --name "run_REGEM" --destination "/GEM-REGEM-Comparisons/Results/REGEM/bmiE/results" -iinputfile="/GEM-REGEM-Comparisons/Results/GEMv1.4.1/sexE_bmiI/combined/gem_sexE_bmiI_combined.out" -iexposure_names="BMI" -ioutput_style="full" -icpu=1 -idisk=10 -imemory=3 -ipreemptible=0 -y


#WHR phenotype, GxSex + GxBMI
dx run run_regem --instance-type mem1_ssd1_v2_x8 --name "run_REGEM" --destination "/GEM-REGEM-Comparisons/Results/REGEM/sexE_bmiE/results" -iinputfile="/GEM-REGEM-Comparisons/Results/GEMv1.4.1/sexE_bmiI/combined/gem_sexE_bmiI_combined.out" -iexposure_names="sex BMI" -ioutput_style="full" -icpu=1 -idisk=10 -imemory=3 -ipreemptible=0 -y


#WHR phenotype, GxSex + GxBMI
dx run run_regem --instance-type mem1_ssd1_v2_x8 --name "run_REGEM" --destination "/GEM-REGEM-Comparisons/Results/REGEM/sexI_bmiE/results" -iinputfile="/GEM-REGEM-Comparisons/Results/GEMv1.4.1/sexE_bmiI/combined/gem_sexE_bmiI_combined.out" -iexposure_names="BMI" -iint_covar_names="sex"  -ioutput_style="full" -icpu=1 -idisk=10 -imemory=3 -ipreemptible=0 -y


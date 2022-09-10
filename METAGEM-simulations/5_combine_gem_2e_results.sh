#!/bin/bash
dx mkdir "/METAGEM-METAL-Comparisons/2-Exposures/GEM/combined"

for i in {1..22}
do
	dx cd "/METAGEM-METAL-Comparisons/2-Exposures/GEM/100k_1/Chr${i}"
	dx mv "gem_res" "ukb_chr${i}_100k_1_sexE_bmiE.out"
	dx download "ukb_chr${i}_100k_1_sexE_bmiE.out"
	if [[ $i -gt 1 ]]
  	then
		tail -n +2 "ukb_chr${i}_100k_1_sexE_bmiE.out" >> "ukb_100k_1_sexE_bmiE.out"
  	else
  		cat "ukb_chr${i}_100k_1_sexE_bmiE.out" >> "ukb_100k_1_sexE_bmiE.out"
	fi
done
dx cd "/METAGEM-METAL-Comparisons/2-Exposures/GEM/combined"
dx upload "ukb_100k_1_sexE_bmiE.out"


for i in {1..22}
do
	dx cd "/METAGEM-METAL-Comparisons/2-Exposures/GEM/Xk_1/Chr${i}"
	dx mv "gem_res" "ukb_chr${i}_Xk_1_sexE_bmiE.out"
	dx download "ukb_chr${i}_Xk_1_sexE_bmiE.out"
	if [[ $i -gt 1 ]]
	then
		tail -n +2 "ukb_chr${i}_Xk_1_sexE_bmiE.out" >> "ukb_Xk_1_sexE_bmiE.out"
	else
		cat "ukb_chr${i}_Xk_1_sexE_bmiE.out" >> "ukb_Xk_1_sexE_bmiE.out"
	fi
done
dx cd "/METAGEM-METAL-Comparisons/2-Exposures/GEM/combined"
dx upload "ukb_Xk_1_sexE_bmiE.out"


for j in {1..2}
do
	for i in {1..22}
	do
		dx cd "/METAGEM-METAL-Comparisons/2-Exposures/GEM/50k_${j}/Chr${i}"
		dx mv "gem_res" "ukb_chr${i}_50k_${j}_sexE_bmiE.out"
		dx download "ukb_chr${i}_50k_${j}_sexE_bmiE.out"
		if [[ $i -gt 1 ]]
		then
			tail -n +2 "ukb_chr${i}_50k_${j}_sexE_bmiE.out" >> "ukb_50k_${j}_sexE_bmiE.out"
		else	
			cat "ukb_chr${i}_50k_${j}_sexE_bmiE.out" >> "ukb_50k_${j}_sexE_bmiE.out"			
		fi
	done
       dx cd "/METAGEM-METAL-Comparisons/2-Exposures/GEM/combined"
	dx upload "ukb_50k_${j}_sexE_bmiE.out"
done


for j in {1..7}
do
	for i in {1..22}
	do
		dx cd "/METAGEM-METAL-Comparisons/2-Exposures/GEM/10k_${j}/Chr${i}"
		dx mv "gem_res" "ukb_chr${i}_10k_${j}_sexE_bmiE.out"
		dx download "ukb_chr${i}_10k_${j}_sexE_bmiE.out"
		if [[ $i -gt 1 ]]
		then
			tail -n +2 "ukb_chr${i}_10k_${j}_sexE_bmiE.out" >> "ukb_10k_${j}_sexE_bmiE.out"		
		else
			cat "ukb_chr${i}_10k_${j}_sexE_bmiE.out" >> "ukb_10k_${j}_sexE_bmiE.out"
		fi
	done
       dx cd "/METAGEM-METAL-Comparisons/2-Exposures/GEM/combined"
	dx upload "ukb_10k_${j}_sexE_bmiE.out"
done

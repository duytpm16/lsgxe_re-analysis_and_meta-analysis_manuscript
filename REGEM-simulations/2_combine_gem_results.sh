#!/bin/bash

se=("model-based" "robust")
sets=("bmiE" "sexI_bmiE" "sexE_bmiE")


#WHR phenotype, GxSex + GxBMI
for i in {1..22} # Chromosomes
do
	dx cd "/GEM-REGEM-Comparisons/Results/GEMv1.4.1/sexE_bmiI/chr${i}"
	dx mv "gem_res" "gem_sexE_bmiI_chr${i}.out"
	dx download "gem_sexE_bmiI_chr${i}.out"
	dx mv "system_resource_usage.log" "gem_sexE_bmiI_chr${i}_system_resource_usage.out"
	dx download "gem_sexE_bmiI_chr${i}_system_resource_usage.out"
	dx mv "process_resource_usage.log" "gem_sexE_bmiI_chr${i}_process_resource_usage.out"
	dx download "gem_sexE_bmiI_chr${i}_process_resource_usage.out"
	
	if [[ $i -gt 1 ]]
	then
		tail -n +3 "gem_sexE_bmiI_chr${i}.out" >> "gem_sexE_bmiI_combined.out"
	else
		cat "gem_sexE_bmiI_chr${i}.out" >> "gem_sexE_bmiI_combined.out"
	fi

	rm "gem_sexE_bmiI_chr${i}.out"
done

dx cd "/GEM-REGEM-Comparisons/Results/GEMv1.4.1/sexE_bmiI/"
dx mkdir "combined"
dx cd "combined"
dx upload "gem_sexE_bmiI_combined.out"

#WHR phenotype, GxSex + GxBMI
for k in "${sets[@]}"
do
	for j in {1..1} # Model-based or Robust
	do
 		for i in {1..22} # Chromosomes
 		do
  			dx cd "/GEM-REGEM-Comparisons/Results/GEMv1.4.1/${k}/chr${i}/${se[j]}"
  			dx mv "gem_res" "gem_${k}_chr${i}.out"
			dx download "gem_${k}_chr${i}.out"
			dx mv "system_resource_usage.log" "gem_${k}_chr${i}_system_resource_usage.out"
   			dx download "gem_${k}_chr${i}_${se[j]}_system_resource_usage.out"
			dx mv "process_resource_usage.log" "gem_${k}_chr${i}_process_resource_usage.out"
			dx download "gem_${k}_chr${i}_process_resource_usage.out"
			
			if [[ $i -gt 1 ]]
			then
				tail -n +3 "gem_${k}_chr${i}.out" >> "gem_${k}_combined.out"
			else
				cat "gem_${k}_chr${i}.out" >> "gem_${k}_combined.out"
			fi

			rm "gem_${k}_chr${i}.out"
 		done

		dx cd "/GEM-REGEM-Comparisons/Results/GEMv1.4.1/${k}/"
		dx mkdir "combined"
		dx cd "combined"
		dx upload "gem_${k}_combined.out"
	done
done

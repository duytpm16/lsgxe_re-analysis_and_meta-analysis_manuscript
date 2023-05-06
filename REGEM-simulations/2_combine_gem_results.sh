#!/bin/bash

sets=("sexE" "bmiE" "sexI_bmiE" "sexE_bmiI" "sexE_bmiE")

for k in "${sets[@]}"
do
	for i in {1..22} # Chromosomes
	do
		dx cd "/GEM-REGEM-Comparisons/Results/v2/GEMv1.5/${k}/chr${i}"
		dx mv "gem_res" "gem_${k}_chr${i}.out"
		dx download "gem_${k}_chr${i}.out"
		dx mv "system_resource_usage.log" "gem_${k}_chr${i}_system_resource_usage.out"
		dx download "gem_${k}_chr${i}_system_resource_usage.out"
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

	dx cd "/GEM-REGEM-Comparisons/Results/v2/GEMv1.5/${k}/"
	dx mkdir "combined"
	dx cd "combined"
	dx upload "gem_${k}_combined.out"
done

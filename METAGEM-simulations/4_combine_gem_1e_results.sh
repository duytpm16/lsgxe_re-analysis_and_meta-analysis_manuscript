#!/bin/bash

sets=("100k_1" "50k_1" "50k_2" "10k_1" "10k_2" "10k_3" "10k_4" "10k_5" "10k_6" "10k_7" "Xk_1")

dx mkdir "/METAGEM-METAL-Comparisons/1-Exposure/v2/GEM/combined"

for j in "${sets[@]}"
do
	for i in {1..22} # Chromosomes
	do
		dx cd "/METAGEM-METAL-Comparisons/1-Exposure/v2/GEM/${j}/Chr${i}"
		dx mv "gem_res" "gem_${j}_chr${i}.out"
		dx download "gem_${j}_chr${i}.out"

		if [[ $i -gt 1 ]]
		then
			tail -n +3 "gem_${j}_chr${i}.out" >> "gem_${j}_combined.out"
		else
			cat "gem_${j}_chr${i}.out" >> "gem_${j}_combined.out"
		fi

		rm "gem_${j}_chr${i}.out"
	done

	dx cd "/METAGEM-METAL-Comparisons/1-Exposure/v2/GEM/combined"
	dx upload "gem_${j}_combined.out"
done

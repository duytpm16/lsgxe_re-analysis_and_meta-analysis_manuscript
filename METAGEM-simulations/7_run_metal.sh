#!/bin/bash

#WHR phenotype, GxSex

# 1-Exposure Meta-analysis
dx cd "/METAGEM-METAL-Comparisons/1-Exposure/GEM/combined"
dx run /run_metal_modelbased --instance-type mem1_ssd1_v2_x8 --name "run_METAEGEM" --destination "/METAGEM-METAL-Comparisons/1-Exposure/METAGEM/model-based/" -iinputfiles="gem_100k_1_combined.out gem_50k_1_combined.out gem_50k_2_combined.out gem_10k_1_combined.out gem_10k_2_combined.out gem_10k_3_combined.out gem_10k_4_combined.out gem_10k_5_combined.out gem_10k_6_combined.out gem_10k_7_combined.out gem_Xk_1_combined.out" -icpu=1 -idisk=10 -imemory=3 -ipreemptible=0 -y

dx run /run_metal_robust --instance-type mem1_ssd1_v2_x8 --name "run_METAEGEM" --destination "/METAGEM-METAL-Comparisons/1-Exposure/METAGEM/robust" -iinputfiles="gem_100k_1_combined.out gem_50k_1_combined.out gem_50k_2_combined.out gem_10k_1_combined.out gem_10k_2_combined.out gem_10k_3_combined.out gem_10k_4_combined.out gem_10k_5_combined.out gem_10k_6_combined.out gem_10k_7_combined.out gem_Xk_1_combined.out" -icpu=1 -idisk=10 -imemory=3 -ipreemptible=0 -y


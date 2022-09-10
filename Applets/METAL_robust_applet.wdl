task run_metal_robust {
	Array[File] inputfiles
	Int? memory
	Int? cpu
	Int? disk
	Int? preemptible
	command {
		dstat -c -d -m --nocolor > system_resource_usage.log &
		atop -x -P PRM | grep '(metal)' > process_resource_usage.log &
		
		for c in ${sep=" " inputfiles}
		do 
			echo $c
			echo "MARKERLABEL  SNPID
SEPARATOR TAB
ALLELELABELS  Non_Effect_Allele Effect_Allele
FREQ  AF
EFFECTLABEL Beta_G
STDERR   robust_SE_Beta_G
SCHEME   INTERACTION
INTEFFECTLABEL Beta_G-sex
INTSTDERRLABEL robust_SE_Beta_G-sex
INTCOVLABEL    robust_Cov_Beta_G_G-sex
FREQLABEL AF
PROCESS "$c"
" >> metal_file
		done
		echo "ANALYZE" >> metal_file
		
		/metal-workflow/executables/metal metal_file
	}
	runtime {
		docker: "dx://file-G935Kzj06y173kpZK7f7yvq6"
		memory: "${memory} GB"
		cpu: "${cpu}"
		disks: "local-disk ${disk} HDD"
		preemptible: "${preemptible}"
		gpu: false
		dx_timeout: "7D0H00M"
	}
	output {
		File out1 = "METAANALYSIS1.TBL"
		File out2 = "METAANALYSIS1.TBL.info"
		File system_resource_usage = "metal_system_resource_usage.log"
		File process_resource_usage = "metal_process_resource_usage.log"
	}
}

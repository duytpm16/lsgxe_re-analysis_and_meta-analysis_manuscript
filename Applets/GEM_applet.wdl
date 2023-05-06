task run_gem_pgen {
	File pgenfile
	File psamfile
	File pvarfile
	Float? maf = 0.001
	File phenofile
	String sample_id_header
	String outcome
	String exposure_names
	String? int_covar_names
	String? covar_names
	Int? center = 2
	String? delimiter = ","
	String? missing = "NA"
	Boolean robust
	String? output_style = "full"
	Float? tol = 0.000001
	Int? threads = 4
	Int? stream_snps = 1
	Int? memory = 10
	Int? cpu = 4
	Int? disk = 50
	Int? preemptible = 1
	Int? monitoring_freq = 1

	String robust01 = if robust then "1" else "0"

	command {
		dstat -c -d -m --nocolor ${monitoring_freq} > system_resource_usage.log &
		atop -x -P PRM ${monitoring_freq} | grep '(GEM)' > process_resource_usage.log &

		/GEM/GEM \
			--pgen ${pgenfile} \
			--psam ${psamfile} \
			--pvar ${pvarfile} \
			--maf ${maf} \
			--pheno-file ${phenofile} \
			--sampleid-name ${sample_id_header} \
			--pheno-name ${outcome} \
			--exposure-names ${exposure_names} \
			${"--int-covar-names " + int_covar_names} \
			${"--covar-names " + covar_names} \
			--center ${center} \
			--delim ${delimiter} \
			--missing-value ${missing} \
			--robust ${robust01} \
			--output-style ${output_style} \
			--tol ${tol} \
			--threads ${threads} \
			--stream-snps ${stream_snps} \
			--out gem_res
	}

	runtime {
		docker: "quay.io/large-scale-gxe-methods/gem-workflow:v1.5a"
		memory: "${memory} GB"
		cpu: "${cpu}"
		disks: "local-disk ${disk} HDD"
		preemptible: "${preemptible}"
		maxRetries: 2
		gpu: false
		dx_timeout: "7D0H00M"
	}

	output {
		File out = "gem_res"
		File system_resource_usage = "system_resource_usage.log"
		File process_resource_usage = "process_resource_usage.log"
	}
}

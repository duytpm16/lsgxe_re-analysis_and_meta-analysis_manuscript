task run_metagem {
	Array[File] inputfiles
	String exposure_names
	Int meta_option
	Int? memory
	Int? cpu
	Int? disk
	Int? preemptible
	Int? monitoring_freq = 1

	command {
		dstat -c -d -m --nocolor ${monitoring_freq} > system_resource_usage.log &
		atop -x -P PRM ${monitoring_freq} | grep '(METAGEM)' > process_resource_usage.log &

		/METAGEM/METAGEM \
			--input-files ${sep=" " inputfiles} \
			--exposure-names ${exposure_names} \
			--meta-option ${meta_option} \
			--out metagem_results
	}

	runtime {
		docker: "dx://project-FyJ05zQ06y16kP7b5vQZXZvP:file-GV4XXY006y1P97JgK5xY5gY4"
		memory: "${memory} GB"
		cpu: "${cpu}"
		disks: "local-disk ${disk} HDD"
		preemptible: "${preemptible}"
		gpu: false
		dx_timeout: "7D0H00M"
	}

	output {
		File out = "metagem_results"
		File system_resource_usage = "system_resource_usage.log"
		File process_resource_usage = "process_resource_usage.log"
	}
}

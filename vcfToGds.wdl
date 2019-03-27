task runGds {
	File vcf
	Int disk
	Float memory
	Int cpus

	String out_base = basename(vcf, ".vcf.gz")


	command {
#		R --vanilla --args ${vcf} ${out_base} ${cpus}< /vcfToGds/vcfToGds.R
		R --vanilla --args ${vcf} ${out_base} < /vcf2Gds/vcfToGds.R
	}

	runtime {
		docker: "schoi/vcf2gds:latest"
		disks: "local-disk ${disk} SSD"
		memory: "${memory} GB"
		cpu : "${cpus}"
	}

	output {
		File out_file = "${out_base}.gds"
	}
}

workflow makegds {
	Array[File] vcf_files
	Int this_disk
	Int this_cpus
	Float this_memory

	scatter(this_file in vcf_files) {
		call runGds {
			input: vcf = this_file, disk = this_disk, memory = this_memory, cpus = this_cpus
		}
	}


	output {
		Array[File] gds_files = runGds.out_file
	}
}

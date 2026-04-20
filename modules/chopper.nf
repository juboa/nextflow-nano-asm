

process CHOPPER {
	tag "${sample_id}"
	publishDir "${params.outdir_prefix}/${sample_id}/chopper/", mode: "copy"
	conda "bioconda::chopper"
	
	input:
	tuple val(sample_id), path(fastq_file)

	output:
	tuple val(sample_id), path("${sample_id}_trimmed.fastq.gz"), emit: trimmed_reads
	
	script:
	"""
		gunzip -c ${fastq_file} | chopper -q ${params.chopper_min_quality} -l ${params.chopper_min_length} -t ${task.cpus}| gzip > ${sample_id}_trimmed.fastq.gz
	"""
}


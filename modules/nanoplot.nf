
process NANOPLOT {
	
	tag "${sample_id}"
	publishDir "${params.outdir_prefix}/${sample_id}/nanoplot_${step}/", mode: "copy"
	
	input:
	tuple val(sample_id), path(fastq_file)
	val(step)

	output:
	path "*"
	
	script:
	"""
		NanoPlot --fastq ${fastq_file} --outdir . --threads ${task.cpus}
	"""
}



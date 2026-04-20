
process NANOPLOT {
	
	tag "${sample_id}"
	publishDir "${params.outdir_prefix}/${sample_id}/nanoplot_${step}/", mode: "copy"
	conda "bioconda::nanoplot"

	input:
	tuple val(sample_id), path(fastq_file)
	val(step)

	output:
	path "${sample_id}_sample_${step}", emit: stats
	

	script:
	"""
		NanoPlot --fastq ${fastq_file} --outdir ${sample_id}_sample_${step}	--prefix ${sample_id}_${step}

	"""
}



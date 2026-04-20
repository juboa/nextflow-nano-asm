
process FLYE {
	
	tag "${sample_id}"
	publishDir "${params.outdir_prefix}/${sample_id}/flye/", mode: "copy"
	conda "bioconda::flye=2.9.3"

	input:
	tuple val(sample_id), path(fastq_file)

	output:
	tuple val(sample_id), path("${sample_id}_assembly.fasta"),	emit: assembly
	path "*"
	
	script:
	"""
		flye --nano-hq ${fastq_file} --out-dir . --threads ${task.cpus}
		mv assembly.fasta ${sample_id}_assembly.fasta
	"""
}

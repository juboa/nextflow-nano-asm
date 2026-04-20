process PROKKA {
    tag "${sample_id}"
    publishDir "${params.outdir_prefix}/${sample_id}/prokka/", mode: "copy"
    conda "bioconda::prokka"

    input:
    tuple val(sample_id), path(assembly)

    output:
    path(sample_id), emit: annotation

    script:
    """
    prokka --outdir ${sample_id} ${assembly}

    """
}
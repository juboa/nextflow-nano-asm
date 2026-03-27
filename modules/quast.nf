process QUAST {
    tag "${sample_id}"
    publishDir "${params.outdir_prefix}/${sample_id}/quast/", mode: "copy"
    
    conda "bioconda::quast=5.2.0"

    input:
    tuple val(sample_id), path(assembly)

    output:
    path "*"

    script:
    """
    quast.py ${assembly} --output-dir . --threads ${task.cpus} --label ${sample_id}
    """
}
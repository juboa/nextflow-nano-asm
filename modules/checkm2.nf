

process CHECKM2 {
    tag "${sample_id}"
    publishDir "${params.outdir_prefix}/${sample_id}/checkm2/", mode: "copy"
    conda "bioconda::checkm2"

    input:
    tuple val(sample_id), path(assembly)

    output:
    path(sample_id), emit: checkm2_report

    script:
    """

    checkm2 predict --threads 8 --input ${assembly} --output-directory ${sample_id} --database_path ${params.checkm2_db_path}

    """
}


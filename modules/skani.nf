
process SKANI {
    tag "${sample_id}"
    publishDir "${params.outdir_prefix}/${sample_id}/skani/", mode: "copy"
    conda "bioconda::skani"

    input:
    tuple val(sample_id), path(assembly)
    path(ani_ref_dir)

    output:
    path("${sample_id}_skani_mqc.txt"), emit: skani_results
    path "*"

    script:
    """
    skani dist ${assembly} -r ${ani_ref_dir}/* -o ${sample_id}_skani.tsv

    cat <<EOF > ${sample_id}_skani_mqc.txt
    # id: 'skani_results for ${sample_id}'
    # section_name: 'Skani ani analysis'
    # description: '${assembly} ${sample_id}_skani.tsv'
    # plot_type: 'table'
    # pconfig:
    #    format: '{:.2f}'
    EOF

    cat ${sample_id}_skani.tsv >> ${sample_id}_skani_mqc.txt

    """
}
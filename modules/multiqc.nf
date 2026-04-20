process MULTIQC {
    publishDir "${params.outdir_prefix}/multiqc/", mode: "copy"
    conda "bioconda::multiqc"

    input:
    path(all_reports, stageAs: "reports/?/*")

    output:
    path("multiqc_report.html"), emit: multiqc_report

    script:
    """
    multiqc .
    """
}


include {NANOPLOT as NANOPLOT_BEFORE} from './modules/nanoplot'
include {NANOPLOT as NANOPLOT_AFTER} from './modules/nanoplot'
include {CHOPPER} from './modules/chopper'
include {FLYE} from './modules/flye'
include {QUAST} from './modules/quast'
include {PROKKA} from './modules/prokka'
include {CHECKM2} from './modules/checkm2'
include {MULTIQC} from './modules/multiqc'
include {SKANI} from './modules/skani'


workflow {
	input_ch = Channel.fromPath(params.input_fastq)
					.map { file -> tuple(file.simpleName, file)}
	ani_ref_dir_ch = Channel.fromPath(params.ani_ref_dir).collect()


	NANOPLOT_BEFORE(input_ch, "BEFORE")
	
	CHOPPER(input_ch)

	NANOPLOT_AFTER(CHOPPER.out.trimmed_reads, "AFTER")

	FLYE(CHOPPER.out.trimmed_reads)

	QUAST(FLYE.out.assembly)

	PROKKA(FLYE.out.assembly)

	CHECKM2(FLYE.out.assembly)

	SKANI(FLYE.out.assembly, ani_ref_dir_ch)

	"""
	multiqc_input = NANOPLOT_BEFORE.out.stats
		.mix(NANOPLOT_AFTER.out.stats)
		.mix(QUAST.out.quast_report)
		.mix(PROKKA.out.annotation)
		.mix(CHECKM2.out.checkm2_report)
		.collect()
	"""

	multiqc_input = NANOPLOT_BEFORE.out.stats
		.mix(NANOPLOT_AFTER.out.stats)
		.mix(QUAST.out.quast_report)
		.mix(PROKKA.out.annotation)
		.mix(CHECKM2.out.checkm2_report)
		.mix(SKANI.out.skani_results)
		.collect()
	
	MULTIQC(multiqc_input)
	
}


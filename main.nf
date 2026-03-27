
params.outdir_prefix = "results"

include {NANOPLOT as NANOPLOT_BEFORE} from './modules/nanoplot'
include {NANOPLOT as NANOPLOT_AFTER} from './modules/nanoplot'
include {CHOPPER} from './modules/chopper'
include {FLYE} from './modules/flye'
include {QUAST} from './modules/quast'


workflow {
	input_ch = Channel.
					fromPath(params.input)
					.map { file -> tuple(file.simpleName, file)}

	NANOPLOT_BEFORE(input_ch, "BEFORE")
	CHOPPER(input_ch)
	NANOPLOT_AFTER(CHOPPER.out.trimmed_reads, "AFTER")

	FLYE(CHOPPER.out.trimmed_reads)

	QUAST(FLYE.out.assembly)
	
}


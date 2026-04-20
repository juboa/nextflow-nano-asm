# nextflow-nano-asm

A Nextflow pipeline for de-novo assembly of Nanopore long reads, with read QC, trimming, assembly, annotation, genome completeness assessment, and a final aggregated MultiQC report.

---

## Requirements

- [Nextflow](https://www.nextflow.io/)
- [Micromamba](https://mamba.readthedocs.io/en/latest/installation/micromamba-installation.html) (or Conda) for environment management
- CheckM2 database (see below)
```bash
checkm2 database --download --path databases/
```
---

## Quick Start

```bash
nextflow run main.nf \
    -profile local,micromamba \
    --input_fastq "data/*.fastq.gz" \
    --checkm2_db_path checkm2_db_path
```

---

## Parameters

| Parameter | Default | Description |
|---|---|---|
| `--input_fastq` | `test` | Glob path to input FASTQ / FASTQ.gz file(s) |
| `--outdir_prefix` | `results` | Output directory |
| `--chopper_min_length` | `500` | Minimum read length (bp) |
| `--chopper_min_quality` | `10` | Minimum mean read quality (Phred) |
| `--flye_read_type` | `nano-hq` | Flye read mode: `nano-hq`, `nano-raw`, or `nano-corr` |
| `--checkm2_db_path` | `~/databases/CheckM2_database/uniref100.KO.1.dmnd` | Path to CheckM2 diamond database |

---


## Outputs

```
results/
├── <sample_id>/
│   ├── nanoplot_BEFORE/     # Raw read QC
│   ├── chopper/             # Trimmed reads
│   ├── nanoplot_AFTER/      # Trimmed read QC
│   ├── flye/                # Assembly FASTA + Flye logs
│   ├── quast/               # Assembly stats
│   ├── prokka/              # Annotation files (GFF, GBK, FAA, ...)
│   └── checkm2/             # Completeness report (quality_report.tsv)
└── multiqc/
    ├── multiqc_report.html  # Final aggregated report
    └── multiqc_data/
```

---

## Profiles

| Profile | Description |
|---|---|
| `local` | Run on the local machine |
| `micromamba` | Resolve conda environments with Micromamba (recommended) |

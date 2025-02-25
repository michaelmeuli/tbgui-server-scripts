#!/usr/bin/env bash
#SBATCH --time=03:00:00
#SBATCH --mem-per-cpu=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=tbprofiler
#SBATCH --output=/home/mimeul/shares/MM/PRJEB57919/log/tbprofiler/tbprofiler_%A_%a.out
#SBATCH --error=/home/mimeul/shares/MM/PRJEB57919/log/tbprofiler/tbprofiler_%A_%a.err
#SBATCH --array=0-1

# /sctmp was not in SINGULARITY_BINDPATH even though otherwise stated here: https://docs.s3it.uzh.ch/cluster/containers/
export SINGULARITY_BINDPATH="/scratch,/data,/home/mimeul,/shares/sander.imm.uzh,/sctmp"

sampleIdsString=$1
# IFS=',' read -r -a sampleIdsArray <<< "$sampleIdsString" 
sampleIdsArray=(ERR10610040 ERR10610041)
sample_id=${sampleIdsArray["$SLURM_ARRAY_TASK_ID"]}

module load singularityce

rawdir=/shares/sander.imm.uzh/MM/PRJEB57919/raw 
outdir=/home/mimeul/shares/MM/PRJEB57919/out/
docx=/shares/sander.imm.uzh/MM/PRJEB57919/template/user_template.docx
container_path=/home/mimeul/shares/MM/PRJEB57919/singu/quay.io-biocontainers-tb-profiler-6.3.0--pyhdfd78af_0.img

singularity exec -u "$container_path" tb-profiler profile \
    -1 "$rawdir/${sample_id}_1.fastq.gz" \
    -2 "$rawdir/${sample_id}_2.fastq.gz" \
    -p "${sample_id}" \
    --dir "$outdir" \
    --prefix "$sample_id" \
    --docx \
    --docx_template "$docx" \
    --csv

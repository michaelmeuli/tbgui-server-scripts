#!/usr/bin/env bash
#SBATCH --time=03:00:00
#SBATCH --mem-per-cpu=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=tbprofiler
#SBATCH --output=/home/mimeul/shares/MM/PRJEB57919/log/tbprofiler/tbprofiler_%A_%a.out
#SBATCH --error=/home/mimeul/shares/MM/PRJEB57919/log/tbprofiler/tbprofiler_%A_%a.err

#script is executed from a non-login shell, so some scripts need to be sourced:
source /etc/profile.d/lmod.sh

# Lmod environment (some systems set MODULEPATH etc. here)
source /etc/profile.d/z01_lmodenv.sh
# Lmod itself (defines `module` function)
source /etc/profile.d/lmod.sh

container_path=/home/mimeul/shares/MM/PRJEB57919/singu/quay.io-biocontainers-tb-profiler-6.3.0--pyhdfd78af_0.img

sampleIdsString=$1
rawdir=$2
outdir=$3
docx=$4
template_dir="$(dirname "$docx")"

# /sctmp was not in SINGULARITY_BINDPATH even though otherwise stated here: https://docs.s3it.uzh.ch/cluster/containers/
export APPTAINER_BINDPATH="/sctmp,$rawdir,$outdir,$template_dir"

IFS=',' read -r -a sampleIdsArray <<< "$sampleIdsString"
sample_id=${sampleIdsArray["$SLURM_ARRAY_TASK_ID"]} 

mkdir -p "$outdir"
chmod 777 "$outdir"

/apps/u24/opt/x86_64_v3/apptainer-1.4.1-77twl7nju5gzjt7fbno55qnm7anmvxo7/bin/apptainer exec -u "$container_path" tb-profiler profile \
    -1 "$rawdir/${sample_id}_1.fastq.gz" \
    -2 "$rawdir/${sample_id}_2.fastq.gz" \
    -p "${sample_id}" \
    --dir "$outdir" \
    --prefix "$sample_id" \
    --docx \
    --docx_template "$docx" \
    --csv

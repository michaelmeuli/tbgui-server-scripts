#!/usr/bin/env bash
#SBATCH --time=03:00:00
#SBATCH --mem-per-cpu=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=tbprofiler
#SBATCH --output=/home/mimeul/shares/MM/PRJEB57919/log/tbprofiler/tbprofiler_%A_%a.out
#SBATCH --error=/home/mimeul/shares/MM/PRJEB57919/log/tbprofiler/tbprofiler_%A_%a.err

sampleIdsString=$1
IFS=',' read -r -a sampleIdsArray <<< "$sampleIdsString"
sample_id=${sampleIdsArray["$SLURM_ARRAY_TASK_ID"]} 

#script is executed from a non-login shell, so some scripts need to be sourced:
source /etc/profile.d/lmod.sh
#module load singularityce
module load anaconda3
source /apps/opt/spack/linux-ubuntu20.04-x86_64/gcc-9.3.0/anaconda3-2024.02-1-whphrx3ledrvyrcnibu7lezfvvqltgt5/bin/activate tb-profiler


#sample_id=ERR10610040
#sample_id=$1
sample_id=${sampleIdsArray["$SLURM_ARRAY_TASK_ID"]} 

rawdir=/shares/sander.imm.uzh/MM/PRJEB57919/raw 
outdir=/home/mimeul/shares/MM/PRJEB57919/out/
#docx=/shares/sander.imm.uzh/MM/PRJEB57919/tb-profiler-templates/docx/default_template.docx
docx=/shares/sander.imm.uzh/MM/PRJEB57919/template/user_template.docx

tb-profiler profile --db imm -1 $rawdir/${sample_id}_1.fastq.gz -2 $rawdir/${sample_id}_2.fastq.gz -p "${sample_id}" --dir $outdir --prefix $sample_id --docx --docx_template $docx --csv


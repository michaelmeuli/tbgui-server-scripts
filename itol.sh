#!/usr/bin/env bash
#SBATCH --array=0
#SBATCH --time=03:00:00
#SBATCH --mem-per-cpu=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=itol
#SBATCH --output=/home/mimeul/shares/MM/PRJEB57919/log/itol/itol_%A_%a.out
#SBATCH --error=/home/mimeul/shares/MM/PRJEB57919/log/itol/itol_%A_%a.err


#script is executed from a non-login shell, so some scripts need to be sourced:
source /etc/profile.d/lmod.sh

itolExampleData=/shares/sander.imm.uzh/MM/PRJEB57919/iTOL/example_data.zip 

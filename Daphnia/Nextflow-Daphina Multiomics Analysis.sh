i#!/bin/bash
#SBATCH --ntasks 1
#SBATCH --time 5-10:0:0
#SBATCH --qos castles
#SBATCH --mail-type ALL

set -e

module purge; module load bluebear

module load FastQC/0.11.9-Java-11
module load Trimmomatic/0.39-Java-11
module load STAR/2.7.1a-GCC-8.2.0-2.31.1

source activate MyNextflow

nextflow run /rds/projects/o/orsinil-popgenomics/Vignesh/RNAseq/Muhammad/STARRNAseq_workflow.nf -qs 20

source deactivate MyNextflow

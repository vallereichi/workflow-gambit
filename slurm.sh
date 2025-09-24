#!/bin/bash -l

#SBATCH --job-name=gambit
#SBATCH --output=runs/slurm-output/%x/out_%A/out.%a
#SBATCH --error=runs/slurm-output/%x/err_%A/err.%a
#SBATCH --array=1-10
#SBATCH --mem=40G
#SBATCH --time=1-00:00:00

INPUT_FILE=$(basename "$1")
INPUT_DIR=$(dirname "$1")
OUTPUT_DIR="/ptmp/vreich/gambit/$SLURM_JOB_NAME-$SLURM_ARRAY_JOB_ID"


module load apptainer/1.4.1

mkdir -p /ptmp/vreich/gambit/$SLURM_JOB_NAME-$SLURM_ARRAY_JOB_ID

srun mkdir -p $OUTPUT_DIR/$SLURM_ARRAY_TASK_ID && \
	apptainer exec --compat --pwd /work/gambit \
	--bind $OUTPUT_DIR/$SLURM_ARRAY_TASK_ID:/work/gambit/runs \
	--bind $INPUT_DIR:/yaml_files gambit.sif \
	./gambit -f /yaml_files/$INPUT_FILE -r

echo "starting scan for input file: $INPUT_FILE"
echo "output will be saved to: $OUTPUT_DIR"


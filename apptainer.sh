#!/bin/bash
if module list 2>&1 | grep -q 'apptainer/1.4.1'; then
	echo "Apptainer is already loaded"
else
	echo "loading Apptainer module.."
	module load apptainer/1.4.1
fi

apptainer run --compat --pwd /work/gambit --bind ./runs:/work/gambit/runs --bind ./yaml_files:/yaml_files gambit.sif


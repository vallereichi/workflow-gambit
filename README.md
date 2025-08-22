# GAMBIT configuration

## for MSSM scans with FlexibleSUSY on the HPC raven

In order to run GAMBIT scans on raven, I resorted to using the docker image provided by the GAMBIT foundation,
since compiling the software itself on the HPC did not succeed. Using the docker image comes with the caveat, that you have
to run it with apptainer since Docker itself would require sudo privileges. Luckily, creating the corresponding ```.sif```
file is relatively easy when following the instructions from the
[Apptainer Quickstart Guide]{'https://apptainer.org/docs/user/latest/quick_start.html'}.

Once the ```.sif``` file is obtained a scan can be started with slurm from the slurm batch script ```apptainer.sh```
with the following command:

```
sbatch slurm.sh yaml_files/FS_MSSM7.yaml
```

This will start a scan with the default job-name in an array of 10 jobs dumping the output files to ```/ptmp``` and
writing the output/error logs to ```runs/slurm-output```.

> **_NOTE:_** The job-name will be used for the output files and directories. It is therefore recommended to specify the job-name with the ```--job-name``` flag. Otherwise already existing output may be overwritten or the scan will simply fail.

> **_NOTE:_** slurm specific flags can be set to overwrite other defaults as well. This way one can easily change scale of ascan or similar options

To run a different scan you can write your own ```input.yaml``` file and specify it in the run command

```
sbatch --job-name=your-job slurm.sh /path/to/your/input/file
```

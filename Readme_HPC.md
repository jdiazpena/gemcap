## HPC notes

This assumes the HPC is using TORQUE scheduler.
To run anything more than a tiny simulation requires requesting an HPC job via Torque.
The PyGemini `gemini3d.gemini_run` program will generate HPC batch scripts when run on HPC.

### submit job

```sh
qsub my.job
```

When job is done, text log files named like "my.job.*" are created in the same directory, giving text feedback and errors.

### Check job status

```sh
qstat -u username
```

### delete a job

Either before or while a job is running, stop the job using the job number obtained from `qstat`

```sh
qdel job_number
```

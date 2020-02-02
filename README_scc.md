## SCC HPC notes

These notes are only relevant to those using SCC HPC.

To run anything more than a few minute job requires requesting a job.
See the job.sh files in this repo for examples.

### submit job

```sh
qsub job.sh
```

When job is done, text files starting with job.sh are created in the same directory.
They tell if something was detected to go wrong.

### Check job status

```sh
qstat -u myusername
```

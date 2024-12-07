# tbgui-server-scripts

Scripts run on the cluster started by [tbgui](https://github.com/michaelmeuli/tbgui)<br>

For now only the batch script "tbprofiler.sh" is submitted to SLURM with the sbatch command.<br>
This scripts then starts [TB-Profiler](https://github.com/jodyphelan/TBProfiler).

## Install TB-Profiler
On cluster computer:
```
module load mamba
conda create --name tb-profiler
conda activate tb-profiler
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
mamba install -c bioconda tb-profiler
```


## Mutation library

- [Mutation database](https://github.com/jodyphelan/TBProfiler?tab=readme-ov-file#mutation-database)
- [Mutation library](https://jodyphelan.github.io/tb-profiler-docs/en/mutation-library/)

Commit currenctly in use: 72ef6fa

The development of the mutation library is hosted on the [tbdb repository](https://github.com/jodyphelan/tbdb).<br><br>
If you would like to use an altered database you can download the tbdb repo, make the required changes and run the following code from within the tbdb repo directory:<br>

```
tb-profiler create_db --prefix <new_library_name>
tb-profiler load_library <new_library_name>
```
The library in use was created with commit: 72ef6fa<br> 
The created libraris was named "imm" and is used via: "tb-profiler profile --db imm ..."<br>


To update and list the libraries:<br>
```
tb-profiler update_tbdb --branch tbdb
tb-profiler update_tbdb --branch who
tb-profiler list_db
```

## Also see:

- [ScienceCluster](https://www.zi.uzh.ch/en/teaching-and-research/science-it/computing/sciencecluster.html)
- [ScienceCluster overview on S3IT](https://docs.s3it.uzh.ch/cluster/overview/)
- [About SLURM workload manager on S3IT](https://docs.s3it.uzh.ch/cluster/cluster_training/#41-what-is-slurm)
- [SLURM Documentation](https://slurm.schedmd.com/)
- [Conda](https://conda.io/projects/conda/en/latest/user-guide/getting-started.html)
- [How to use Conda environments on ScienceCluster](https://docs.s3it.uzh.ch/how-to_articles/how_to_use_conda/)

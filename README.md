# opgee-docker

This repo contains a Dockerized version of the [OPGEE v4](https://github.com/Stanford-EAO/OPGEEv4) tool.

## Building the container

To build the container, first [install Docker](https://docs.docker.com/engine/install/) or an equivalent containerization engine, then run:

```bash
docker build -t opgee .
```

## Running the container

The default entrypoint for the container prepares a [`conda` environment](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html) with the `opg` tool. For example:

```bash
$ docker run --rm -it opgee opg --help
usage: opg [-h] [--logLevel LOGLEVEL] [--set name=value] [--verbose] [--version] [--VERSION] {compare,config,csv2xml,gensim,graph,gui,merge,run,runsim} ...

[... more output omitted ...]
```

To run a script, put it in a file, mount it as a volume, and set it as the command. E.g for a script like [`examples/script.sh`]:

```bash
$ docker run --rm -it --volume $PWD/examples/script.sh:/script.sh:ro opgee /script.sh
INFO opgee.mcs.simulation: * Ignoring distribution on gas_lifting, Binary distribution has prob_of_yes = 0.0
[...]
INFO opgee.xml_utils: Writing '/output/merged_model.xml'
INFO opgee.mcs.simulation: Writing '/output/gas_lifting_field/trial_data.csv'
INFO opgee.mcs.distributed_mcs_dask: Creating local cluster
INFO opgee.mcs.distributed_mcs_dask: Starting local cluster
INFO opgee.mcs.distributed_mcs_dask: Waiting for workers
INFO opgee.mcs.distributed_mcs_dask:
Workers are running
INFO opgee.mcs.distributed_mcs_dask: Running MCS for field 'gas_lifting_field'
INFO opgee.field: Running trial 0 of <Field 'gas_lifting_field'>
[...]
INFO opgee.mcs.simulation: Writing '/output/gas_lifting_field/results.csv'
INFO opgee.mcs.distributed_mcs_dask: Stopping cluster
INFO opgee.mcs.distributed_mcs_dask: <Timer 'Manager.run_mcs' completed in 0:00:32>

```

# generic_docker_framework
A template for getting up and running quickly in Docker with Jupyter notebooks and from the command line.

## Background

This is a framework for getting started on something in Docker.

It allows one to use Jupyter notebooks or to run Python from the command line, which are two common ways or working.

Jupyter and all of its dependencies are the only packages in [requirements.txt](./requirements.txt), and all versions have been pinned.

## Requirements

- [Docker](https://www.docker.com/products/docker-desktop)

## Nice to Haves

- [make](https://www.gnu.org/software/make/manual/make.html)

## Usage

Only the usage with `make` has been documented below.

Take a look at the [Makefile](./Makefile) to see the commands corresponding to the targets.

0. Build the image.
```
make build
```

### Jupyter Notebook Usage

1. To see how to run a Jupyter notebook in the container run this.
```
make jupyter
```

After you do, you should see something like the following at the command line.
```
docker run --publish 8888:8888 --volume $(pwd)/notebooks:/workspace/notebooks --detach generic jupyter
68634eea7fcb08ddf751e162ff91f0eb651c6c15ae8d2763e6b5ebb7d06e49b8
```

2. Go to http://localhost:8888/notebooks/notebooks/hello_world.ipynb, and run the notebook.

You should see this in the output of cell 1.
```
[0, 1, 2, 3, 4]
```

3. Stop the container.
```
make stop
```

### Command Line Usage

1. Run the hello_world.py script.
```
make hello_world
```

After you do, you should see something like this at the command line.
```
docker run --volume $(pwd)/scripts:/workspace/scripts generic python /workspace/scripts/hello_world.py
[0, 1, 2, 3, 4]
```

## Other Things

Use `make docker-clean-unused` to nuke containers on your machine that aren't running.  Watch out.

Use `make docker-clean-all` to kill **all** containers, running or not.  Careful.

Use `make shell` to peek inside the container.

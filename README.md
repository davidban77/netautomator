# NetAutomator

It contains Dockerfile specs for building network automation focused workstations.

## How it works

Images are separated inside their respective folder in `docker/`. This way you can build an image from the parent directory like:

```shell
docker build -t <some tag> -f docker/<image type>/Dockerfile .
```

For example:

```shell
docker build -t davidban77/netautomator:workstation -f docker/workstation/Dockerfile .
```

It will create the miniconda3/debian based container, that has the following attributes:

- [Miniconda 3](https://docs.conda.io/projects/conda/en/latest/): Which is based on Python 3 and serves as environment manager. You can create different python environments and the best part is that you can select the python version you need.
- OpenSSH Server and client: So you can ssh into the container and ssh from it.
- ZSH: As the shell program customized with [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- `net-tools`: Where you can use the likes of `traceroute` or `netstat`.
- Python Poetry: For python porjects managements
- Git
- Vim

You can then connect to it:

```shell
docker run -it davidban77/netautomator:workstation
```

It will then open a `zsh` session to the container.

## Docker images

- `workstation`: Which serves as base image.
- `ansible`: Which contains extra configutation for ansible projects. It also installs `ansible` and `ansible_runner`. Also serves as `latest`

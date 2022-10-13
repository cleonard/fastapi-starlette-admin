# fastapi-starlette-admin

Sample app with [FastAPI](https://fastapi.tiangolo.com/) and [Starlette-Admin](https://jowilf.github.io/starlette-admin/) for ATX Python Meetup 12 Oct 2022

# Installation

I'm using Vagrant to run an Ubuntu VM on my local machine. The `Vagrantfile`
provisions, via `provision.sh` the VM installing `miniconda` and `PostgreSQL`.
It also creates the and starts the Linux service to run FastAPI.

Note that we're creating a `conda` environment called `admin`. If you'd like to
change the name of the environment, you'll have to change the corresponding
diretory in the `ExecStart` section of the `fastapi.service` file before
provisioning the VM.

A `requirements.txt` file is provided, both for `conda` dependency installation
and to facilitate other environment creation methods.

- Run `vagrant ssh` to SSH into the machine
- Run `conda activate admin` to activate the conda environment
- Install `starlette-admin` and `sqlalchemy[asyncio]` via pip
- `cd /vagrant`, and seed the database:
  `python app/database/seed.py` which creates the `tasks` table and adds
  stubbed task data from `tasks.txt`

# Caveats

- `starlette-admin` doesn't appear to be available via Anaconda. Installed via
  pip: `pip install starlette-admin`
- Requires `SQlAlchemy` with asyncio. I removed `sqlalchemy` from
  `requirements.txt` and manually installed: `pip install sqlalchemy[asyncio]`
- `starlette-admin` seems to require [SQLModel](https://sqlmodel.tiangolo.com/),
  a light wrapper over `Pydantic` and `SQLAlchemy` written by the creator of
  `FastAPI`

# See Also:

- Related projects: https://github.com/jowilf/starlette-admin#related-projects-and-inspirations
- Previous FastAPI presenter's repo with resources in the README: https://github.com/fusecloud/fastapi_atx
- [SQLModel](https://sqlmodel.tiangolo.com/)
- Starlette Admin demo: https://starlette-admin-demo.jowilf.com/
- Starlette Admin demo source: https://github.com/jowilf/starlette-admin-demo

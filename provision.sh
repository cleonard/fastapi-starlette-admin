CONDA_DOWNLOAD=https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
CONDA_FILE=Miniconda3-latest-Linux-x86_64.sh
ENV_NAME=fastapi

# Update/upgrade apt
echo "=== Update apt ==="
echo ""
sudo apt-get update -y
sudo apt update -y
sudo apt-get upgrade -y
sudo apt upgrade -y

# Ensure basic packages are installed
echo ""
echo "=== Basic pkgs ==="
echo ""

sudo apt install mlocate -y
sudo apt install nano -y
sudo apt install wget -y

# Install miniconda
echo ""
echo "=== Insstall miniconda ==="
echo ""

cd ~  # Ensure that we're in home dir

if [[ ! -f $CONDA_FILE ]]; then
  curl $CONDA_DOWNLOAD -o $CONDA_FILE
fi

bash $CONDA_FILE -b

source ~/miniconda3/etc/profile.d/conda.sh
conda init bash
source ~/.bashrc

# Create conda environment
echo ""
echo "=== conda environment ==="
echo ""
conda create -n $ENV_NAME python=3.10 -y
conda activate $ENV_NAME

# Install our app's dependencies into the conda env
# Create conda environment
echo ""
echo "=== Install dependencies ==="
echo ""

conda install -c conda-forge fastapi uvicorn sqlalchemy alembic click faker pytest jupyter jupyterlab -y

# Starlette Admin isn't currently available via Anaconda, install via pip
pip install starlette-admin

# Install PostgreSQL
echo ""
echo "=== Install PostgreSQL ==="
echo ""

sudo apt install -y postgresql postgresql-contrib
sudo apt-get install libpq-dev
sudo apt install -y postgresql-client-common

# Install and start service to run our app in the VM
echo ""
echo "=== Linux service to run FastAPI app ==="
echo ""

sudo cp /vagrant/fastapi.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable fastapi
sudo systemctl start fastapi
sudo systemctl status fastapi

APP_DIR=/vagrant
CONDA_DOWNLOAD=https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
CONDA_FILE=Miniconda3-latest-Linux-x86_64.sh
ENV_NAME=admin

# Update/upgrade apt
echo "=== Update apt-get =========="
echo ""

sudo apt-get update -y
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get upgrade -y

# Ensure common packages are installed
echo ""
echo "=== Common pkgs =========="
echo ""

sudo apt-get install mlocate -y
sudo apt-get install nano -y
sudo apt-get install wget -y

# Install miniconda
echo ""
echo "=== Install miniconda =========="
echo ""

cd ~  # Ensure that we're in home dir

if [[ ! -f $CONDA_FILE ]]; then
  curl $CONDA_DOWNLOAD -o $CONDA_FILE
fi

bash $CONDA_FILE -b

source ~/miniconda3/etc/profile.d/conda.sh
conda init bash
source ~/.bashrc

# Update conda
conda update -n base -c defaults conda

# Conda environment
bash /vagrant/conda_env.sh

# Install PostgreSQL
echo ""
echo "=== Install PostgreSQL =========="
echo ""

sudo apt-get install -y postgresql postgresql-contrib
sudo apt-get install libpq-dev
sudo apt-get install -y postgresql-client-common

# Create `vagrant` user and database
sudo -u postgres psql -c "CREATE USER vagrant WITH PASSWORD 'passw0rd' CREATEDB;"
sudo -u vagrant psql -d postgres  -c "CREATE DATABASE api_admin;"

# Install and start service to run our app in the VM
echo ""
echo "=== Linux service to run FastAPI app =========="
echo ""

sudo cp /vagrant/fastapi.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable fastapi
sudo systemctl start fastapi
sudo systemctl status fastapi

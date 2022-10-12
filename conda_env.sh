cd /vagrant
conda create -n admin python=3.10 -y
conda install --force-reinstall -y -n admin -c conda-forge --file requirements.txt

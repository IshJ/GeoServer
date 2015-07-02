# Run this on an AWS machine to install the GeoServer.
# Preinstalled on AMI geoserver.euclid.cristipp (ami-3beed40b)
# Use http://geoserver4.euclid.cristipp.dev.ai2:8080/questions/list/all to test.
# May not work out of the box, prepare to troubleshoot and/or run the commands manually.
# Get on the AWS machine:
# $ scp install.sh cristipp@geoserver4.euclid.cristipp.dev.ai2:/home/cristipp/install.sh 
# $ ssh geoserver4.euclid.cristipp.dev.ai2

sudo apt-get update
sudo apt-get install mysql-client mysql-server libmysqlclient-dev
sudo apt-get install python-pip libblas-dev liblapack-dev gfortran python-numpy python-scipy python-matplotlib
sudo pip install scikit-learn sympy networkx nltk inflect pyparsing pydot2 mysql-python django django-picklefield jsonfield django-storages boto django-modeldict pillow unipath beautifulsoup4 requests
sudo apt-get install build-essential unzip
sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
sudo pip install awscli
echo "create database geodb" | mysql -u root

sudo su ai2service <<'EOF'
aws configure
cd ~
wget https://github.com/Itseez/opencv/archive/3.0.0.zip
unzip 3.0.0.zip
cd opencv-3.0.0/
mkdir release
cd release
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=~/usr/local -D Python_ADDITIONAL_VERSIONS=2.7 ..
make
make install
cd ~
# git clone https://github.com/allenai/GeoServer
# git clone https://github.com/allenai/geosolver
# git clone https://github.com/allenai/EquationTree
ghro GeoServer
ln -s /opt/ai2ools/var/ghro/allenai/GeoServer GeoServer
ghro geosolver
ln -s /opt/ai2ools/var/ghro/allenai/geosolver geosolver
ghro EquationTree
ln -s /opt/ai2ools/var/ghro/allenai/EquationTree EquationTree
cd GeoServer/geoserver
# https://github.com/allenai/ai2ools/blob/master/lib/bash/helpers.sh
aws s3 cp s3://geosolver-server/dump/89a68dc2de4e87bfc2f09ad41ef25a1b1911dd60/labels.json .
aws s3 cp s3://geosolver-server/dump/89a68dc2de4e87bfc2f09ad41ef25a1b1911dd60/questions.json .
aws s3 cp s3://geosolver-server/dump/89a68dc2de4e87bfc2f09ad41ef25a1b1911dd60/media.tar.gz .
tar -xvzf media.tar.gz
python manage.py migrate --settings=geoserver.settings.local
python manage.py loaddata questions.json --settings=geoserver.settings.local
python manage.py loaddata labels.json --settings=geoserver.settings.local
# python manage.py loaddata semantics.json --settings=geoserver.settings.local
export PYTHONPATH=~/geosolver:~/EquationTree:~/usr/local/lib/python2.7/dist-packages; nohup python manage.py runserver 0:8080 --settings=geoserver.settings.local 2>&1 > log.txt &
EOF


# Run this on an AWS machine to install the GeoServer.
# Preinstalled on AMI geoserver.euclid.cristipp (ami-3beed40b)
# Use http://$IP:8080/questions/list/all to test.
# May not work out of the box, prepare to troubleshoot and/or run the commands manually.

sudo apt-get update
sudo apt-get install mysql-client mysql-server libmysqlclient-dev
echo "create database geodb" | mysql -u root
sudo apt-get install python-pip libblas-dev liblapack-dev gfortran python-numpy python-scipy python-matplotlib
pip install scikit-learn sympy networkx nltk inflect pyparsing pydot2 mysql-python django django-picklefield jsonfield django-storages boto django-modeldict pillow unipath beautifulsoup4 requests
sudo apt-get install build-essential
sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
wget https://github.com/Itseez/opencv/archive/3.0.0.zip
unzip 3.0.0.zip
cd opencv-3.0.0/
mkdir release
cd release
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..
make
sudo make install
cd ~
git clone https://github.com/allenai/GeoServer
git clone https://github.com/allenai/geosolver
git clone https://github.com/allenai/EquationTree
cd GeoServer/geoserver
python manage.py migrate --settings=geoserver.settings.local
export PYTHONPATH=~/geosolver:~/EquationTree; python manage.py runserver 0:8080 --settings=geoserver.settings.local


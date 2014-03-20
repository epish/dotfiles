#!/bin/bash

install_package() {
    distr="$1"
    if ! hash $distr 2>/dev/null; then
        repo="$2"
        echo "Installing $distr from $repo"
        wget $repo -O - | sudo python
    else
        echo "$distr is already installed"
    fi
}

install_deb_package() {
    distr="$1"
    if ! hash $distr 2>/dev/null; then
        repo="$2"
        echo "Installing $repo with apt-get"
        sudo apt-get install -y $repo
    else
        echo "$distr is already installed"
    fi
}

install_pip_package() {
    distr="$1"
    if ! hash $distr 2>/dev/null; then
        name="$2"
        echo "Installing $name with pip"
        sudo pip install $name
    else
        echo "$distr is already installed"
    fi
}

install_libs() {
    distr="$1"
    dpkg --status $distr  2>&1 >/dev/null | grep -q "not installed"
    if [ $? -eq 0 ]; then
        echo "Installing $distr"
        sudo apt-get install -y $distr
    fi
}

#setuptools
#https://pypi.python.org/pypi/setuptools#installation-instructions
install_package easy_install "https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py"

#python-pip
install_deb_package pip python-pip

#nose
#https://nose.readthedocs.org/en/latest/
install_pip_package nosetests nose

#install  MySQLdb aka mysql-python
for lib in libmysqlclient-dev python-dev
do
    install_libs $lib
done;

sudo pip install MySQL-python

#create skeleton structur for python projects
cd ~
mkdir -p python/projects/skeleton 
cd python/projects/skeleton 
mkdir bin tests docs templates NAME

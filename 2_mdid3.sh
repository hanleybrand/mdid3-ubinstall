#!/bin/bash
#

echo '====Step 2  begins ====' 

sudo apt-get install openjdk-6-jre-headless     
sudo apt-get install python-setuptools
sudo apt-get install libjpeg62-dev
sudo apt-get install unixodbc
sudo apt-get install unixodbc-dev
sudo apt-get install freetds-dev
sudo apt-get install tdsodbc
sudo apt-get install python-dev
sudo apt-get install libmysqlclient16-dev
sudo apt-get install python-ldap
sudo apt-get install python-memcache
sudo apt-get install memcached
sudo apt-get install libapache2-mod-wsgi
sudo apt-get install g++
sudo apt-get install mysql-server
       
sudo easy_install pyodbc
sudo easy_install mysql-python
sudo easy_install pil
sudo easy_install python-dateutil
sudo easy_install flickrapi
sudo easy_install werkzeug
sudo easy_install reportlab

echo '====Step 2 complete - on to step 3!!! ====' 

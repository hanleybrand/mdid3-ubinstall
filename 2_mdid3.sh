#!/bin/bash
#

echo '====Step 2  begins ====' 
#make dir for error reports just incase
mkdir errors

#send errors to a text file in the errors dir
sudo apt-get install openjdk-6-jre-headless 2> errors/openjdk-6-jre-headless-errors.txt
sudo apt-get install python-setuptools 2> errors/python-setuptools-errors.txt
sudo apt-get install libjpeg62-dev 2> errors/libjpeg62-errors.txt
sudo apt-get install unixodbc 2> errors/unixodbc-errors.txt
sudo apt-get install unixodbc-dev 2> errors/unixodbc-dev-errors.txt
sudo apt-get install freetds-dev 2> errors/freetds-errors.txt
sudo apt-get install tdsodbc 2> errors/tdsodbc-errors.txt
sudo apt-get install python-dev 2> errors/python-dev-errors.txt
sudo apt-get install libmysqlclient16-dev 2> errors/libmysqlclient16-errors.txt
sudo apt-get install python-ldap 2> errors/python-ldap-errors.txt
sudo apt-get install python-memcache 2> errors/python-memcache-errors.txt
sudo apt-get install memcached 2> errors/memcached-errors.txt
sudo apt-get install libapache2-mod-wsgi 2> errors/libapache2-mod-wsgi-errors.txt
sudo apt-get install g++ 2> errors/g++-errors.txt
sudo apt-get install mysql-server 2> errors/mysql-server-errors.txt
       
sudo easy_install pyodbc 2> errors/pyodbc-errors.txt
sudo easy_install mysql-python 2> errors/pyodbc-errors.txt
sudo easy_install pil 2> errors/pyodbc-errors.txt
sudo easy_install python-dateutil 2> errors/pyodbc-errors.txt
sudo easy_install flickrapi 2> errors/pyodbc-errors.txt
sudo easy_install werkzeug 2> errors/pyodbc-errors.txt
sudo easy_install reportlab 2> errors/pyodbc-errors.txt

echo '==== Readying database user - enter mysql root pass when asked ====' 

mysql -h 3_mdid3.sql -u 'root' -p  2> errors/mysql-errors.txt

echo '====installing MDID 3 ====' 

cd /var/local/mdid
git init
git remote add rooibos git://github.com/cit-jmu/rooibos.git
git fetch rooibos
git merge rooibos/master

sudo chown -R mdid:staff /var/local/mdid/*

echo '====preparing virtual machine===='

#copy the apache.conf file to the right place

# copy settings_local.template.py settings_local.py

cp /var/local/mdid/rooibos/settings_local.template.py /var/local/mdid/rooibos/settings_local.py

# 
cd cd /var/local/mdid/rooibos
python manage.py syncdb --noinput
python manage.py createcachetable cache
#

#!/bin/bash
#

echo '====Step 2  begins ====' 
#make dir for error reports just incase
echo 'mkdir errors'
mkdir errors

# 2> send errors to a text file in the errors dir, -y says "yes" to questions

echo 'apt-getting...'
sudo apt-get install openjdk-6-jre-headless -y 2> errors/openjdk-6-jre-headless-errors.txt
sudo apt-get install python-setuptools -y 2> errors/python-setuptools-errors.txt
sudo apt-get install libjpeg62-dev -y  2> errors/libjpeg62-errors.txt
sudo apt-get install unixodbc -y  2> errors/unixodbc-errors.txt
sudo apt-get install unixodbc-dev -y  2> errors/unixodbc-dev-errors.txt
sudo apt-get install freetds-dev -y  2> errors/freetds-errors.txt
sudo apt-get install tdsodbc -y  2> errors/tdsodbc-errors.txt
sudo apt-get install python-dev -y  2> errors/python-dev-errors.txt
sudo apt-get install libmysqlclient16-dev -y  2> errors/libmysqlclient16-errors.txt
sudo apt-get install python-ldap -y  2> errors/python-ldap-errors.txt
sudo apt-get install python-memcache -y  2> errors/python-memcache-errors.txt
sudo apt-get install memcached -y  2> errors/memcached-errors.txt
sudo apt-get install libapache2-mod-wsgi -y  2> errors/libapache2-mod-wsgi-errors.txt
sudo apt-get install g++  -y 2> errors/g++-errors.txt
sudo apt-get install mysql-server -y  2> errors/mysql-server-errors.txt
echo 'easy-installing...'
sudo easy_install pyodbc 2> errors/pyodbc-errors.txt
sudo easy_install mysql-python 2> errors/pyodbc-errors.txt
sudo easy_install pil 2> errors/pyodbc-errors.txt
sudo easy_install python-dateutil 2> errors/pyodbc-errors.txt
sudo easy_install flickrapi 2> errors/pyodbc-errors.txt
sudo easy_install werkzeug 2> errors/pyodbc-errors.txt
sudo easy_install reportlab 2> errors/pyodbc-errors.txt

#data base section
echo '==== Readying database user - enter mysql root pass when asked ====' 

echo "mysql  -u 'root' -p < 3_mdid3.sql 2> errors/mysql-errors.txt"
mysql  -u 'root' -p < 3_mdid3.sql 2> errors/mysql-errors.txt

echo '====installing MDID 3 ====' 
# git some mdid3

echo 'cd /var/local/mdid'
cd /var/local/mdid
echo 'sudo git init'
sudo git init
echo 'sudo git remote add rooibos git://github.com/cit-jmu/rooibos.git'
sudo git remote add rooibos git://github.com/cit-jmu/rooibos.git
echo 'sudo git fetch rooibos'
sudo git fetch rooibos
echo 'sudo git merge rooibos/master'
sudo git merge rooibos/master
echo 'sudo chown -R mdid:staff /var/local/mdid/*'
sudo chown -R mdid:staff /var/local/mdid/*

echo '====preparing virtual machine===='

#copy the apache.conf file to the right place
echo 'sudo cp ~/mdid3-ubinstall/mdid3vm.conf /etc/apache2/httpd.conf'
sudo cp ~/mdid3-ubinstall/mdid3vm.conf /etc/apache2/httpd.conf

# copy preconfigured settings_local.py to rooibos dir 
echo 'sudo cp ~/mdid3-ubinstall/settings_local.py /var/local/mdid/rooibos/settings_local.py'
sudo cp ~/mdid3-ubinstall/settings_local.py /var/local/mdid/rooibos/settings_local.py
echo "=====don't forget to double check your settings_local.py!====="
# 

echo 'cd /var/local/mdid/rooibos'
cd /var/local/mdid/rooibos
echo 'sudo python manage.py syncdb --noinput'
sudo python manage.py syncdb --noinput
echo 'sudo python manage.py createcachetable cache'
sudo python manage.py createcachetable cache
#
echo 'sudo /etc/init.d/apache2 reload'
sudo /etc/init.d/apache2 reload


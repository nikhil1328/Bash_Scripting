#! /bin/bash
# Sunday June 07 2020. 
## Purpose : Bash Script to create Virtual host. (Name base) ##
## Author :  Nikhill Narendra Kulkarni ##
################################################################################################
#Install Apache
yum install httpd -y

#Create the direcctories.
mkdir -p /var/www/myserver-1.com/public_html
mkdir -p /var/www/myserver-2.com/public_html

#Grant Permissions
chown -R $USER:$USER /var/www/myserver-1.com/public_html
chown -R $USER:$USER /var/www/myserver-2.com/public_html
chmod -R 755 /var/www

#Create Demo Pages for Each Virtual Host
#For myserver-1.com
echo "<html>
  <head>
    <title>Welcome to myserver-1.com!</title>
  </head>
  <body>
    <h1>Success! The myserver-1.com virtual host is working!</h1>
  </body>
</html>" >> /var/www/myserver-1.com/public_html/index.html

#For myserver-2.com
echo "<html>
  <head>
    <title>Welcome to myserver-2.com!</title>
  </head>
  <body>
    <h1>Success! The myserver-2.com virtual host is working!</h1>
  </body>
</html>"  >> /var/www/myserver-2.com/public_html/index.html

#Create New Virtual Host Files
mkdir /etc/httpd/sites-available
mkdir /etc/httpd/sites-enabled

#Update the httpd.conf file.
echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf

#Create the First Virtual Host File
#touch /etc/httpd/sites-available/myserver-1.com.conf
echo "<VirtualHost *:80>

    ServerName www.myserver-1.com
    ServerAlias myserver-1.com
    DocumentRoot /var/www/myserver-1.com/public_html
    ErrorLog /var/www/myserver-1.com/error.log
    CustomLog /var/www/myserver-1.com/requests.log combined
</VirtualHost>" >> /etc/httpd/sites-available/myserver-1.com.conf

#touch /etc/httpd/sites-available/myserver-2.com.conf
echo "<VirtualHost *:80>
    ServerName www.myserver-2.com
    DocumentRoot /var/www/myserver-2.com/public_html
    ServerAlias myserver-2.com
    ErrorLog /var/www/myserver-2.com/error.log
    CustomLog /var/www/myserver-2.com/requests.log combined
</VirtualHost>" >> /etc/httpd/sites-available/myserver-2.com.conf

#Enable the New Virtual Host Files
ln -s /etc/httpd/sites-available/myserver-1.com.conf /etc/httpd/sites-enabled/myserver-1.com.conf
ln -s /etc/httpd/sites-available/myserver-2.com.conf /etc/httpd/sites-enabled/myserver-2.com.conf

#Restart the Service.
apachectl restart

echo "127.0.0.1 myserver-1.com
127.0.0.1 myserver-2.com" >> /etc/hosts

echo "Done"

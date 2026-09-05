yum install java-21-amazon-corretto -y

wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.121/bin/apache-tomcat-9.0.121.tar.gz

tar -zxvf apache-tomcat-9.0.121.tar.gz

sed -i '56 a\<role rolename="manager-gui"/>' apache-tomcat-9.0.121/conf/tomcat-users.xml
sed -i '57 a\<role rolename="manager-script"/>' apache-tomcat-9.0.121/conf/tomcat-users.xml
sed -i '58 a\<user username="tomcat" password="admin@123" roles="manager-gui,manager-script"/>' apache-tomcat-9.0.121/conf/tomcat-users.xml
sed -i '59 a\</tomcat-users>' apache-tomcat-9.0.121/conf/tomcat-users.xml

sed -i '21d' apache-tomcat-9.0.121/webapps/manager/META-INF/context.xml
sed -i '22d' apache-tomcat-9.0.121/webapps/manager/META-INF/context.xml

sh apache-tomcat-9.0.121/bin/startup.sh

#Enter into /root/apache-tomcat-9.0.121 and  execute below commands

cat > tomcat-users.xml <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users xmlns="http://tomcat.apache.org/xml"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
              version="1.0">

    <role rolename="manager-gui"/>
    <role rolename="manager-script"/>
    <user username="tomcat" password="admin@123" roles="manager-gui,manager-script"/>

</tomcat-users>
EOF

cd /root/apache-tomcat-9.0.121

sh bin/shutdown.sh
sleep 5
sh bin/startup.sh

curl -s -o /dev/null -w '%{http_code}\n' -u 'tomcat:admin@123' http://localhost:8080/manager/html

#200 → credentials are working

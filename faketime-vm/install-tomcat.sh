echo "Step 1: Installing OpenJDK 1.8.0..."
sudo yum install -y java-1.8.0-openjdk-devel
echo "export JAVA_HOME=/etc/alternatives/java_sdk" >> $HOME/.bashrc
echo

echo "Step 2: Intalling Tomcat ...."
rm -f apache-tomcat-8.5.11.tar.gz
curl -O http://mirror.catn.com/pub/apache/tomcat/tomcat-8/v8.5.11/bin/apache-tomcat-8.5.11.tar.gz
sudo rm -rf /usr/local/apache-tomcat*
sudo tar -zxf apache-tomcat-8.5.11.tar.gz -C /usr/local 
sudo ln -s /usr/local/apache-tomcat-8.5.11 /usr/local/apache-tomcat
sudo ln -s /usr/local/apache-tomcat $HOME/tomcat
echo "export TOMCAT_HOME=/usr/local/apache-tomcat" >> $HOME/.bashrc
echo

echo "Step 3: Opening Tomcat port 8080.."
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --reload

echo "Note: Tomcat's shutdown script does not work properly in this release. You may have to use the kill command to kill the tomcat process for stopping Tomcat.." 
echo

echo Done


Part 1 : (Testing with Self-Signed certs)

1. vagrant up; vagrant ssh

2. cd /vagrant
   install-nginx.sh

3. create the self signed cert pairs and dh-param file. 
   Note this step can be skipped as they have already been generated.

   $ gen-cert-pair.sh
   ensure the CN = admin.getstatepension.psn.dwp.gsi.gov.uk

   $ gen-dh-param.sh

4. cd /etc/nginx/conf.d
   rename the existing ssl.conf file ssl.conf.bak
   copy the self-signed-ssl.conf.bak to self-signed-ssl.conf

5. cp certs/old and certs/self-signed directories to /etc/ssl

6. sudo nginx -t 

7. Restart nginx, sudo systemctl restart nginx

8. On the client machine, ensure that there is a mapping for the hostname admin.getstatepension.psn.dwp.gsi.gov.uk to 192.68.75.75

9. Open a browser and enter, https://admin.getstatepension.psn.dwp.gsi.gov.uk

Part 2 : (Testing with Production certs)

1. Rename the self-signed-ssl.conf to self-signed-ssl.conf.bak

2. Copy the prod-ssl.conf to /etc/nginx/conf.d

3. And also the redirect.conf

4. Restart nginx and do the same testing.


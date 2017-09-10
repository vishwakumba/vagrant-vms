1. Build the Vagrant machine

2. Install Jira 

   $ vagrant ssh
   $ cd /vagrant
   $ sudo ./atlassian-jira-software-7.3.6-x64.bin

 This may take a few mins.You will be prompted for a number of manual inputs.

3. Launch the browser at http://localhost:8080/ and complete the rest of the steps.
    eg: creating the database, creating a sample project..

4. Install Atlassian SDK kit

   $ cd /vagrant
   $ ./install-atlassian-sdk.sh

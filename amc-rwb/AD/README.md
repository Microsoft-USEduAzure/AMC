THE MODERN DATA WAREHOUSE SCRIPT REP

These scripts support the automation of deployment for the Modern Data Warehouse.
It removes the infrastructure steps for the data analyst or data scientist so they can work with the essential business of data
vs. the Azure resources behind it.
The scripts are interactive and dynamically fill in the requirements, removing the need to build out everything in the portal.

A log file is generated in the end with the name of the resoruces, passwords, etc.

Instructions:
Download the entire contents as a zip file
Prerequisites:
-Azure Cloud Shell acount: https://docs.microsoft.com/en-us/azure/cloud-shell/overview
-Azure cloud storage to store and run scripts connected to shell: https://docs.microsoft.com/en-us/azure/cloud-shell/persisting-shell-storage

1. Keep the files in a zip format once downloaded.
2. Open up the Azure portal and click on the Cloud Shell icon in the upper right hand list of icons, ( >_ )
3. Once open, use the icon to upload files to upload the zip file to the cloud shell, (icon is a page with up and down arrows)
4. Once the zip file is uploaded, perform the following:
   a.  unzip the file-  unzip <zip file name>.zip
   b.  change over to directory created as part of zip- cd <directory name>
   c.  Update permissions for the shell script: chmod 774 mdw_deploy.sh 
   d.  Run the script:  ./mdw_deploy.sh
   e.  Answer the questions for the deployment.
   f.  As resources deploy, you can monitor the status by going into the resource group in the Azure portal and clicking the refresh button in the Resource Group, (not for the browser.)
   g.  Once completed, you can review all the information about the deployment in the mdw_deploy.txt log file:  view mdw_deploy.txt
   THAT IS ALL.


# boshAIProject3

Steps involved:
1. Download the Project Starter Folder and open it in VS code
2. Access your Lab Credentials 
3. Open the downloaded folder in your favorite editor and login to azure with az login 
4. Create a `config.sh` file in the terraform directory to deploy your terraform backend script
5. Cd to the terraform directory and run bash config.sh using `bash config.sh`
6. Copy the output and create a `azseret.conf` where you will add all the output from the `config.sh`.
7. Get information about your subscription from the portal and add it to your `azsecret.conf`
8. Add a VM that the agent will use for deployment say `myLinuxAgent`
9. Also, add the information to your  terraform.tfvar and add the other modules.
10. Confirm the resource group name and the location from Azure portal
11. After that push your code to GitHub, that is after creating a new repo

Head over to Azure DevOps Organization
1.Login to Azure DevOps organization
2.Create a new organization say `UCL_p3demo`
3.Create PAT
4.Create Service Connection (manual)
5.Create a new agent pool (You would have created a Linux VM in Azure portal that the agent will use)

Steps to create a new agent, download and install on the VM created
# Download the agent
curl -O https://vstsagentpackage.azureedge.net/agent/2.202.1/vsts-agent-linux-x64-2.202.1.tar.gz
# Create the agent
mkdir myagent && cd myagent
tar zxvf ../vsts-agent-linux-x64-2.202.1.tar.gz
# Configure the agent
./config.sh To run the configuration
sudo ./svc.sh install - To install svc
sudo ./svc.sh start - To start the VM
1.Create an environment say `TEST` and install it in the created VM
2.Install terraform from marketplace
3.Add secure files and upload azsecret and ssh key that you have generated.
4.Add variable at the point of deploying the yaml file
5.Deploy your yaml file, after a successful deployment.

Note: before running the pipeline, you need to install below on your VM so as not to encounter any error
On the Linux VM you need to install below

sudo apt-get -y install zip to install ZIP
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash to install Azure CLI
sudo apt-get install npm to install NPM

Next step is to move to Azure portal, from Azure portal inside the Azure Devops resource group, we have a LAW created for us already, you just need to install the agent
1.ssh into the Linux agent created (myLinuxAgent)
2.Goto Agents management > Linux server > Log Analytics agent instructions > Download and onboard agent for Linux
3.It will take some time to reflect.
Next is to
Create a new alert for the App Service
a) From the Azure Portal go to:
Home > Resource groups > "RESOURCE_GROUP_NAME" > "App Service Name" > Monitoring > Alerts
b) Click on New alert rule
c) Double-check that you have the correct resource to make the alert for.
d) Under Condition click Add condition
d) Choose a condition e.g. Http 404
e) Set the Threshold value to e.g. 1. (You will get altered after two consecutive HTTP 404 errors)
f) Click Done
Create a new action group for the App Service
a) In the same page, go to the Actions section, click Add action groups and then Create action group
b) Give the action group a name e.g. http404
c) Add an Action name e.g. HTTP 404 and choose Email/SMS message/Push/Voice in Action Type.
d) Provide your email and then click OK
Create AppServiceHTTPLogs
Go to the App service > Diagnostic Settings > + Add Diagnostic Setting. Tick AppServiceHTTPLogs and Send to Log Analytics Workspace created on step above and Save.
Go back to the App service > App Service Logs . Turn on Detailed Error Messages and Failed Request Tracing > Save. Restart the app service.
Setting up Log Analytics
Set up custom logging, in the log analytics workspace go to Settings > Custom Logs > Add + > Choose File. Select the file selenium.log > Next > Next. Put in the following paths as type Linux:
/var/log/selenium/selenium.log
I called it selenium_CL, Tick the box Apply below configuration to my Linux machines.
Go back to Log Analytics workspace and run below query to see Logs

AppServiceHTTPLogs 
|where _SubscriptionId contains "sub_id"
| where ScStatus == '404'
Go back to the App Service web page and navigate on the links and also generate 404 not found , example:
https://p3demo-appservice.azurewebsites.net/sheeeeee

https://p3demo-appservice.azurewebsites.net/first page
After the trigger, check the email configured since an alert message will be received. Take screenshot and zip your folder for submission. (edited) 

#Connect to Azure
Connect-AzAccount
#Switch to the Sandbox subscription
Set-AzContext ed89df52-d2d3-4790-bf82-ebf1a17fb97b
#Collect the parameters from the user
$devName = Read-Host -Prompt "Enter your developer name"
$rgName = "rg-dev-${devName}"
$devSqlServer = "sql-dev-${devName}"
$adminUser = Read-Host -Prompt "Enter the SQL server administrator username" 
#$adminUser = "ServerAdmin"
$adminPassword = Read-Host -Prompt "Enter the SQl server administrator password" -AsSecureString 
#$adminPassword = ConvertTo-SecureString("P1n38ppl3")
$JSONTemplateFile = "rg-dev-template.json"
$JSONTemplateUri = "https://dev.azure.com/ISGDevelopment/Data%20Warehouse/_apis/sourceProviders/TfsGit/filecontents?repository=Data%20Warehouse&commitOrBranch=master&path=%2FARM%2FInfrastructureBuild%2F${JSONTemplateFile}&api-version=5.0-preview.1"
$localPath = "C:\Users\staggart\OneDrive - ISG PLC\Documents\source\repos\Data Warehouse\ARM\InfrastructureBuild\"

#Create the Resource Group
New-AzResourceGroup -Name $rgName -Location "West Europe" -force

#Run the template to rebuild
Test-AzResourceGroupDeployment -ResourceGroupName $rgName -TemplateFile $localPath$JSONTemplateFile -administratorLogin $adminUser -administratorLoginPassword $adminPassword -buildServerName $devSqlServer
#-TemplateUri $JSONTemplateUri 

#Tell the user what's been set
Write-Host "Resource Group is: ${rgName}"
Write-Host "SQL Server Name is: ${devSqlServer}"
Write-Host "SQL Server Admin is: ${adminUser}"
Write-Host "Template File is: ${localPath}${JSONTemplateFile}"
Write-Host "Template URI is: ${JSONTemplateUri}"
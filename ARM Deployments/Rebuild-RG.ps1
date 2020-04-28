#Connect to Azure
Connect-AzAccount
#Switch to the Sandbox subscription
Set-AzContext ed89df52-d2d3-4790-bf82-ebf1a17fb97b
#Collect the parameters from the user
$devName = Read-Host -Prompt "Enter your developer name (no spaces)"
$rgName = "rg-dev-${devName}"
$devSqlServer = "sql-dev-${devName}"
$adminUser = Read-Host -Prompt "Enter the SQL server administrator username" 
$adminPassword = Read-Host -Prompt "Enter the SQl server administrator password" -AsSecureString 
$JSONTemplateFile = "rg-dev-template.json"
$JSONTemplateUri = "https://raw.githubusercontent.com/simontaggart/AzureTemplates/master/ARM%20Deployments/${JSONTemplateFile}"

#Create the Resource Group
New-AzResourceGroup -Name $rgName -Location "West Europe" -force

#Run the template to rebuild
New-AzResourceGroupDeployment -ResourceGroupName $rgName -TemplateUri $JSONTemplateUri  -administratorLogin $adminUser -administratorLoginPassword $adminPassword -buildServerName $devSqlServer
#-TemplateUri $JSONTemplateUri 
#-TemplateFile $localPath$JSONTemplateFile

#Tell the user what's been set
Write-Host "Your Resource Group is: ${rgName}"
Write-Host "Your SQL Server is: ${devSqlServer}"
Write-Host "Your SQL Server Admin is: ${adminUser}"
#Write-Host "Template URI is: ${JSONTemplateUri}"
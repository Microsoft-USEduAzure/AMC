# TITLE: New Research Workbench Deploy
# DETAILS: Deploy a mixed IaaS/PaaS Research environment secured to allow for on-prem to Azure but not Internet to Azure research computing
# AUTHOR: Joey Brakefield

$rwbname = "rwb"
$location = "eastus"

New-AzResourceGroup -Name "$rwbname1-rg" -Location $location

# Deploy the foundational VNET
New-AzureRmResourceGroupDeployment -TemplateParameterFile ".\0-foundation\parameters.json" -TemplateFile ".\0-foundation\template.json"

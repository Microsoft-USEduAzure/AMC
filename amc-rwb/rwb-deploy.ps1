# TITLE: New Research Workbench Deploy
# DETAILS: Deploy a mixed IaaS/PaaS Research environment secured to allow for on-prem to Azure but not Internet to Azure research computing
# AUTHOR: Joey Brakefield

$rwbname = "rwb"
$location = "eastus"
$rwbrg = "$rwbname-rg"
$rwbmgmtrg = "$rwbname"+ "mgmt-rg"



# Deploy the foundational VNET If not deploying the Bastion Host
#New-AzResourceGroupDeployment -TemplateParameterFile ".\0-foundation\parameters.json" -TemplateFile ".\0-foundation\template.json" -ResourceGroupName $rwbmgmtrg

# Deploy Resource Group for VNET and Bastion Host
New-AzResourceGroup -name $rwbmgmtrg -Location $location
# Deploy the Bastion Host for Secured VNET access to all your IaaS resources
New-AzResourceGroupDeployment -TemplateFile ".\1-azbastionbroker\bastiondeploy.json" -ResourceGroupName $rwbmgmtrg -TemplateParameterFile ".\1-azbastionbroker\bastiondeploy.parameters.json" -location $location 

# Now Let's Deploy the Workbench Resources
New-AzResourceGroup -name $rwbrg -Location $location

# First let's deploy a secure Ubuntu Data Science VM
New-AzResourceGroupDeployment -TemplateFile ".\2-dsvm-ubuntu\udsvm.template.json" -ResourceGroupName $rwbmgmtrg -TemplateParameterFile ".\2-dsvm-ubuntu\udsvm.parameters.json" -location $location 

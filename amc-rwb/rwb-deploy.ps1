# TITLE: New Research Workbench Deploy
# DETAILS: Deploy a mixed IaaS/PaaS Research environment secured to allow for on-prem to Azure but not Internet to Azure research computing
# AUTHOR: Joey Brakefield

$rwbname = "rwb"
$location = "eastus"
$rwbrg = "$rwbname-rg"
$rwbmgmtrg = "$rwbname"+ "mgmt-rg"

# Deploy the foundational VNET for IaaS Workloads
New-AzResourceGroup -name $rwbmgmtrg -Location $location
$vnetparams = @{
    vnetName = "$rwbname-vnet"
}
$vnetdeploy = New-AzResourceGroupDeployment -TemplateParameterObject $vnetparams -TemplateFile ".\0-foundation\rwbvnet.template.json" -ResourceGroupName $rwbmgmtrg

$vnet = Get-AzVirtualNetwork -ResourceGroupName $rwbmgmtrg -Name "$rwbname-vnet"

# Deploy Resource Group for VNET and Bastion Host
New-AzResourceGroup -name $rwbmgmtrg -Location $location
# Deploy the Bastion Host for Secured VNET access to all your IaaS resources
$bastionparams = @{
    location = $location
    "vnet-name" = $vnet.name
    "vnet-ip-prefix" = "10.5.0.0/16"
    "vnet-new-or-existing" = "existing"
    "bastion-subnet-ip-prefix" = "10.5.0.0/27"
    "bastion-host-name" = "$rwbname-bastion"

}
New-AzResourceGroupDeployment -TemplateFile ".\1-azbastionbroker\bastiondeploy.json" -ResourceGroupName $rwbmgmtrg -TemplateParameterObject $bastionparams -location $location 


# Now Let's Deploy the Workbench Resources
New-AzResourceGroup -name $rwbrg -Location $location

# First let's deploy a secure Ubuntu Data Science VM
## Let's replace the VNET ID with the one you deployed above
$udsvmpfilepath = ".\2-dsvm-ubuntu\udsvm.parameters.json"
$udsvmparams = Get-Content -Path $udsvmpfilepath -Raw | ConvertFrom-Json
$udsvmparams.parameters.virtualNetworkId = @{value=$vnet.id}  
$udsvmparams | ConvertTo-Json -Depth 100 | foreach { [System.Text.RegularExpressions.Regex]::Unescape($_) } | Set-Content -Path '.\custom-udsvm.parameters.json'


## Now deploy the DSVM to Azure
New-AzResourceGroupDeployment -TemplateFile ".\2-dsvm-ubuntu\udsvm.template.json" -ResourceGroupName $rwbrg -TemplateParameterFile '.\custom-udsvm.parameters.json' -location $location 

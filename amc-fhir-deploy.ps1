# First ensure all modules are installed per the README
## If Using PoSH Core, execute the function below. REF: https://blogs.endjin.com/2019/05/how-to-use-the-azuread-module-in-powershell-core/
function Install-AzureADStandard()
{
	# Check if test gallery is registered
	$packageSource = Get-PackageSource -Name 'Posh Test Gallery'

	if (!$packageSource)
	{
		$packageSource = Register-PackageSource -Trusted -ProviderName 'PowerShellGet' -Name 'Posh Test Gallery' -Location 'https://www.poshtestgallery.com/api/v2/'
	}

	# Check if module is installed
 	$module = Get-Module 'AzureAD.Standard.Preview' -ListAvailable -ErrorAction SilentlyContinue

    	if (!$module) 
	{
        	Write-Host "Installing module AzureAD.Standard.Preview ..."

	        $module = Install-Module -Name 'AzureAD.Standard.Preview' -Force -Scope CurrentUser -SkipPublisherCheck -AllowClobber 

        	Write-Host "Module installed"
	}

	# Module doesn't automatically load after install - need to import explictly for Pwsh Core
	Import-Module $module.RootModule
}

## Uncomment if executing the function above
## Install-AzureADStandard

# Now to execute per the fhir-server-samples original repo --> https://github.com/Microsoft/fhir-server-samples
connect-azureAd -tenantdomain cdc7af66-55f5-47de-a929-1cf27eef876c
 
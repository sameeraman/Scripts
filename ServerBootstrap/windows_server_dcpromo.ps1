Param (
    [string]$domainname
)

# Run the Server base bootstrap script
.\windows_server_base.ps1


#Set Execution Policy to allow script to run
Set-ExecutionPolicy Bypass -Scope Process -Force 


# Install Domain Controller Roles and DNS
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
Install-windowsfeature -name DNS -IncludeManagementTools


Import-Module ADDSDeployment
Install-ADDSForest -CreateDnsDelegation:$false -DomainMode "WinThreshold" -DomainName $domainname -ForestMode "WinThreshold" -InstallDns:$true -NoRebootOnCompletion:$false -Force:$true 

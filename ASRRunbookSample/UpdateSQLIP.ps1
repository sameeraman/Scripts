param (
    [parameter(Mandatory=$false)]
    [Object]$RecoveryPlanContext
)

# Identify the Failover Direction
$RecoveryPlanContextObj = $RecoveryPlanContext | ConvertFrom-Json
$Direction = $RecoveryPlanContextObj.FailoverDirection
Write-Output "Failover Direction Identified as : $Direction" 


# Set the variables according to the failover direction
Write-Output "Setting the variables according to the failover direction" 
if ($Direction -eq "PrimaryToSecondary") {
	$RGName = "cts-use1-prd-rg-spoke-dr-testing"
	$sourceip = "192.168.194.4"
	$targetip = "192.168.195.4"
} else {
	$RGName = "cts-usw2-prd-rg-spoke-dr-testing"
	$sourceip = "192.168.195.4"
	$targetip = "192.168.194.4"
}

# Connect to Azure using Automation account Managed Identity
Write-Output "Connecting to azure via  Connect-AzAccount -Identity" 
Connect-AzAccount -Identity 
Write-Output "Successfully connected with Automation account's Managed Identity" 

Write-Output "Executing Failover Script on the App Server" 
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/sameeraman/Scripts/master/ReplaceStringInFile/ReplaceStringInFile.ps1" -OutFile "ReplaceStringInFile.ps1"
Invoke-AzVMRunCommand -ResourceGroupName $RGName -VMName 'ctsusw2prdvmdr2' -CommandId 'RunPowerShellScript' -ScriptPath 'ReplaceStringInFile.ps1' -Parameter @{FilePath = "C:\inetpub\wwwroot\appsettings.json"; find = $sourceip; Replace = $targetip}


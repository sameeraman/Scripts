# ---------------------------
# Australian Region Creation
# ---------------------------

$ResourceGroupName = "MVP-AUE-PRD-UG-NET"
$location = 'AustraliaEast'
$VNETName = "MVP-AUE-PRD-UG-VNET1"
$AddressSpace = "10.33.0.0/16"


# Create the Resource Group
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $location

# Create the Virtual network 
$virtualNetwork = New-AzureRmVirtualNetwork -ResourceGroupName $ResourceGroupName -Location $location -Name $VNETName -AddressPrefix $AddressSpace

# Add a subnet
$subnetName = "Server"
$subnetPrefix = '10.33.0.0/24'
$virtualNetwork = Get-AzureRmVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VNETName
$subnetConfig = Add-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetPrefix -VirtualNetwork $virtualNetwork
$virtualNetwork | Set-AzureRmVirtualNetwork


# Create the VM 
$VMName = "MVPAUEUGVWAN1"
$username = "azureadmin"
$password = ConvertTo-SecureString -String "********" -AsPlainText -Force 
$creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password
New-AzureRmVm -ResourceGroupName $ResourceGroupName -Location $location -VirtualNetworkName $VNETName -SubnetName $SubnetName -Name $VMName -Credential $creds -AsJob


# ---------------------------
# Azure VWAN Creation
# ---------------------------


# Australian VWAN and HUB Creation
$ResourceGroupName = "MVP-AUE-PRD-UG-VWAN"
$location = 'AustraliaEast'
$VWANName = "MVP-AUE-PRD-UG-VWAN1"
$VWANHubNameAUE = "MVP-AUE-PRD-UG-VWAN1-HUB"
$VWANHUBAddressPrefixAUE = "10.32.0.0/16"
$VWANHubNameAUELocation = 'AustraliaEast'

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $location
New-AzureRmVirtualWan -ResourceGroupName $ResourceGroupName  -Name $VWANName -Location $location
$virtualWan = Get-AzureRmVirtualWan -ResourceGroupName $ResourceGroupName  -Name $VWANName
# Add the VWAN HUB for Australia
New-AzureRmVirtualHub -VirtualWan $virtualWan -ResourceGroupName $ResourceGroupName -Name $VWANHubNameAUE -AddressPrefix $VWANHUBAddressPrefixAUE -Location $VWANHubNameAUELocation

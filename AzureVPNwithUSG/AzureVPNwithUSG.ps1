
# Define Variables
$RG1         = "MVP-EUS-PRD-NET"
$VNet1       = "MVP-EUS-PRD-VNET1"
$Location1   = "East US"
$FESubnet1   = "FrontEnd"
$BESubnet1   = "Backend"
$VNet1Prefix = "192.168.48.0/22"
$FEPrefix1   = "192.168.48.0/24"
$BEPrefix1   = "192.168.49.0/24"
$GwPrefix1   = "192.168.51.0/24"
$Gw1         = "MVP-EUS-PRD-VNET1-GW"
$GwIP1       = "MVP-EUS-PRD-VNET1-GWPIP"
$GwIPConf1   = "MVP-EUS-PRD-VNET1-GWIPCFG"

# Create the Resource Group
New-AzResourceGroup -ResourceGroupName $RG1 -Location $Location1

# Create the VNET
$fesub1 = New-AzVirtualNetworkSubnetConfig -Name $FESubnet1 -AddressPrefix $FEPrefix1
$besub1 = New-AzVirtualNetworkSubnetConfig -Name $BESubnet1 -AddressPrefix $BEPrefix1
$gwsub1 = New-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -AddressPrefix $GwPrefix1
$vnet   = New-AzVirtualNetwork -Name $VNet1 -ResourceGroupName $RG1 -Location $Location1 -AddressPrefix $VNet1Prefix -Subnet $fesub1,$besub1,$gwsub1

# Provision the Gateway
$gwpip    = New-AzPublicIpAddress -Name $GwIP1 -ResourceGroupName $RG1 -Location $Location1 -AllocationMethod Dynamic
$subnet   = Get-AzVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $vnet 
$gwipconf = New-AzVirtualNetworkGatewayIpConfig -Name $GwIPConf1 -Subnet $subnet -PublicIpAddress $gwpip
New-AzVirtualNetworkGateway -Name $Gw1 -ResourceGroupName $RG1 -Location $Location1 -IpConfigurations $gwipconf -GatewayType Vpn -VpnType RouteBased -GatewaySku Basic
$myGwIp = Get-AzPublicIpAddress -Name $GwIP1 -ResourceGroup $RG1  $myGwIp.IpAddress

# Create Local Network Gateway
# On-premises network - LNGIP1 is the VPN device public IP address
$LNG1        = "Treeby"
$LNGprefix1  = "10.1.1.0/24"
$LNGprefix2  = "10.1.2.0/24"
$LNGIP1      = "<< you home public IP >>"
$Connection1 = "VNETtoTreeby"

New-AzLocalNetworkGateway -Name $LNG1 -ResourceGroupName $RG1 -Location 'East US' -GatewayIpAddress $LNGIP1 -AddressPrefix $LNGprefix1,$LNGprefix2

# Create the Connection between the Gateway and the Local Gateway
$vng1 = Get-AzVirtualNetworkGateway -Name $GW1  -ResourceGroupName $RG1
$lng1 = Get-AzLocalNetworkGateway   -Name $LNG1 -ResourceGroupName $RG1
New-AzVirtualNetworkGatewayConnection -Name $Connection1 -ResourceGroupName $RG1 -Location $Location1 -VirtualNetworkGateway1 $vng1 -LocalNetworkGateway2 $lng1 -ConnectionType IPsec -SharedKey "YourKey123"

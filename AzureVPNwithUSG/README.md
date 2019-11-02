# Azure VPN with UniFi Secure Gateway

This script has the list of PowerShell commands that you can use create a hybrid lab environment. It creates a VPN tunnel with terminating with UniFi Secure Gateway. 

![resourceslist](images/vpnusgdiagram.png "Azure VPN Diagram")

The script will create the following resources. 

![resourceslist](images/resources.png "Azure Resources")

The UniFi Secure Gateway Configuration will look like below. You will need to create a new Site to Site VPN and have the following configuration.

![resourceslist](images/usgconfig.png "UniFi Config")

Once you set all setting correctly, your VPN tunnel will get established. It will look like below in the portal. 

![resourceslist](images/connection.png "Azure VPN connection status")
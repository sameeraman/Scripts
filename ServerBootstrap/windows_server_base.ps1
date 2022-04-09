
#Set Execution Policy to allow script to run
Set-ExecutionPolicy Bypass -Scope Process -Force 
#Choco install and Choco Apps
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install microsoft-edge -y
choco install az.powershell -y


# Allow ICMPv4 and v6
Set-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv4-In)" -enabled True
Set-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv6-In)" -enabled True

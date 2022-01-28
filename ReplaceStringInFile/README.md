# Replace String In File Script

This script finds and replaces text on a file provided. It also take a backup of the original file. 

## Example usage
Example usage is to replace Server IP's of configuration file with new Servers IP. It's benefitial in Azure Site Recovery scenario's to automate the configuration file updates with the new server IPs. 

The following script update the .Net Core `appsettings.json` connection string IP with the new server IP. 

```
.\ReplaceStringInFile.ps1 -FilePath "C:\inetpub\wwwroot\appsettings.json" -Find "192.168.201.4" -Replace "192.168.194.4"
```
## An Example file output. 

![](images/mjc99eQWQI.png)
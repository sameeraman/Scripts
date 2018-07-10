# Managed Disk Copy

This script is to be used when you want to make copy of the OS disk as a backup (When you don't have Azure Backups configured). 

First, shutdown the virtual machine. 

Use the given script to make copy of the managed OS disk. At the bottom of the PowerShell file, there's a script block to swap the currect Active OS Disk of the VM. 

Assumptions:  
* This script assumes that you have managed disks for the VM. 
* This script assumes that you copy the OS disk to the same resource group.
* This script assumes that you work on the same subscription.





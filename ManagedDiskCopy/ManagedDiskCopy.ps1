# Login to Azure
Login-AzureRmAccount

# Select the subscription
$subscriptionName = "SP-MVP"
Set-AzureRmContext -SubscriptionName SP-MVP

# Source Information
$sourceResourceGroupName = 'MVP-EUS-TST-STG1'
$managedDiskName = 'MVPEUSTSTVM1'

#Get the source managed disk
$managedDisk = Get-AzureRMDisk -ResourceGroupName $sourceResourceGroupName -DiskName $managedDiskName
 

#Name of the resource group where snapshot will be copied to
$targetResourceGroupName = 'MVP-EUS-TST-STG1'
$targetDiskName = 'MVPEUSTSTVM1-COPY'

#Create a new managed disk in the resource group
$diskConfig = New-AzureRmDiskConfig -SourceResourceId $managedDisk.Id -Location $managedDisk.Location -CreateOption Copy 
New-AzureRmDisk -Disk $diskConfig -DiskName $targetDiskName -ResourceGroupName $targetResourceGroupName


# Swap the disks.
$ResourceGroupName = 'MVP-EUS-TST-STG1'
$VMName = 'MVPEUSTSTVM1'
$NewOSDiskName = 'MVPEUSTSTVM1-COPY'
$vm = Get-AzureRmVM -ResourceGroupName $ResourceGroupName  -Name $VMName  
$disk = Get-AzureRmDisk -ResourceGroupName $ResourceGroupName -Name $NewOSDiskName 
Set-AzureRmVMOSDisk -VM $vm -ManagedDiskId $disk.Id -Name $disk.Name 
Update-AzureRmVM -ResourceGroupName $ResourceGroupName -VM $vm

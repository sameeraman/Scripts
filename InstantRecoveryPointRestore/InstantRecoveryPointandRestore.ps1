
# First, Use the recovery vault and restore the Disk. Disks will be restored as unmanaged disks in to a pointed storage account

#define common parameters
$ResourceGroupName = "MVP-EUS-BLB"

# define parameters for the managed disk creation
$MDOSDiskName = "SP-UNVM-vm1-osmd"
$storageType = 'Premium_LRS'
$location = 'eastus'
$sourceVHDURI = 'https://dfgdfgd.blob.core.windows.net/vhdd84dc5037a04450684bc506e200c0b67/b4ff0e2283ba24b95a6a40a4c757b2a6e.vhd'
$storageAccountId = '/subscriptions/a02aasdfsdff-sdf-wers907f/resourceGroups/MVP-EUS-BLB/providers/Microsoft.Storage/storageAccounts/vmd2fw72vyo4xazdiag1'

# Create a managed disk out of the unmanaged disk
$diskConfig = New-AzureRmDiskConfig -AccountType $storageType -Location $location -CreateOption Import -StorageAccountId $storageAccountId -SourceUri $sourceVHDURI
New-AzureRmDisk -Disk $diskConfig -ResourceGroupName $ResourceGroupName -DiskName $MDOSDiskName

# Now that the managed disk is ready, shutdown the VM so that the OS disks can be swapped. 

# define parameters for disk swap
$ResourceGroupName = "MVP-EUS-BLB"
$VMName = "SP-UNVM-vm1"
$OSDiskName = "SP-UNVM-vm1-osmd"

# Swap the disks.
$vm = Get-AzureRmVM -ResourceGroupName $ResourceGroupName  -Name $VMName  
$disk = Get-AzureRmDisk -ResourceGroupName $ResourceGroupName -Name $OSDiskName 
Set-AzureRmVMOSDisk -VM $vm -ManagedDiskId $disk.Id -Name $disk.Name 
Update-AzureRmVM -ResourceGroupName $ResourceGroupName -VM $vm

# Turn the VM back on
# Instant Recovery Point Restore and Disk Swapping

This script is to be used when using a restore from a instant recovery point in Azure Recovery Vault.

https://azure.microsoft.com/en-au/blog/large-disk-support/


Restore the snapshot as disks. Then use the script to create managed disks out of the unmanaged disks in the storage accounts. And finally do a disk swap to restore the vm to the snapshot copy. 

For more information please visit: 
https://sameeraman.wordpress.com/2018/06/22/disk-swap-for-instant-snapshot-restore-in-azure/





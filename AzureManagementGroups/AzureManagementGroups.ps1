
# Import the Module
Import-Module AzureRM.ManagementGroups

# List all the existing Management Groups
$MGs = Get-AzureRmManagementGroup

# List Subscriptions
Get-AzureRmSubscription | ft

# Create Management Group in Root
New-AzureRmManagementGroup -GroupName MyMG1 -DisplayName "My ManagementGroup1"

# Create Management Group under another group
New-AzureRmManagementGroup -GroupName MySubMG1 -DisplayName "My Sub ManagementGroup 1" -ParentId /providers/Microsoft.Management/managementGroups/MyMG1

# List subscription added to Management Groups
Get-AzureRmManagementGroupSubscription

# Add Subscription to a Management Group
New-AzureRmManagementGroupSubscription -GroupName MyMG1 -SubscriptionId 7f520bc1-34f68-469f-b5bb-56b5685b37f31


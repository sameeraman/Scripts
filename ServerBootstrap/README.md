# Server Bootstrap

This folder contains PowerShell scripts that is used by Azure VM's for bootstrapping. These scripts are constructed and shared by the Sameera as part of his community efforts. 

## Example usage

Use the following script in terraform. Apply it as an extension after provisioning the VM. The extension will execute the powershell script to do the following: 

* Install Microsoft Edge Browser
* Install Azure PowerShell Module
* Disable Windows Firewall 

```terraform
resource "azurerm_virtual_machine_extension" "vm-extension" {
  name                 = "musicstore"
  virtual_machine_id   = module.virtual-machine.vm_id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File MusicStore.ps1 -user ${local.sqladmin} -password ${local.sqlpassword} -sqlserver ${azurerm_mssql_server.sqlserver1.fully_qualified_domain_name} -sqldbname ${azurerm_mssql_database.sqldb1.name}",
        "fileUris": ["https://raw.githubusercontent.com/sameeraman/musicstore-app/main/MusicStore.ps1"]
    }
SETTINGS

  tags                = var.tags
  depends_on          = [module.resource_group_web, module.virtual-machine, azurerm_mssql_server.sqlserver1, azurerm_mssql_database.sqldb1 ]
}
```
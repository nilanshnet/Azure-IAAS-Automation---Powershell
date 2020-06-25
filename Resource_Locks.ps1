
$azure_resource_name = ""        # Input the name of the Resource
$azure_resource_type = ""        # Input the resource Type,  Eg: "Microsoft.Web/sites"
$azure_resourcegroup_name = ""   # Name of the Resource group you want to put lock to

# Locks are inherited by resources when applied on a resource group level
# Use only the resource group parameter instead of Resource type and Resource name, if you want to apply lock to a Resource Group Level 

New-AzResourceLock -LockName "Do-not-Delete" -LockLevel CanNotDelete `
 -ResourceName $azure_resource_name -ResourceType $azure_resource_type -ResourceGroupName $azure_resourcegroup_name

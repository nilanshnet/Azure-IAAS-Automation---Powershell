cls
Login-AzureRmAccount
$subscription_ID = '63f2f6e3-89a1-4677-a780-2f788788f101'
Select-AzureRmSubscription -Subscription $subscription_ID

$diskName = 'gav-arv-dr-dat-dsk-img-050'     # Name of the Managed disk 

$rgName = 'GAV-ARV-DR-DEM-01'                 # resource group that contains the managed disk

$storageType = 'StandardSSD_LRS'                 # Choose between Standard_LRS, StandardSSD_LRS and Premium_LRS based on your scenario 

#$size = 'Standard_DS1_v2'                    # Premium capable size 

#$disk = Get-AzDisk -DiskName $diskName -ResourceGroupName $rgName
$disk = Get-AzureRmDisk -DiskName $diskName -ResourceGroupName $rgName

# Get parent VM resource
$vmResource = Get-AzureRmResource -ResourceId $disk.ManagedBy
#$vmResource = Get-AzResource -ResourceId $disk.ManagedBy

# Stop and deallocate the VM before changing the storage type
Stop-AzureRmVM -ResourceGroupName $vmResource.ResourceGroupName -Name $vmResource.Name -Force
#Stop-AzVM -ResourceGroupName $vmResource.ResourceGroupName -Name $vmResource.Name -Force

$vm = Get-AzureRmVM -ResourceGroupName $vmResource.ResourceGroupName -Name $vmResource.Name
#$vm = Get-AzVM -ResourceGroupName $vmResource.ResourceGroupName -Name $vmResource.Name 

# Change the VM size to a size that supports Premium storage
# In case of GE we have defined the sizes already, but some might change
# Skip this step if converting storage from Premium to Standard
#$vm.HardwareProfile.VmSize = $size
#Update-AzureRmVM -VM $vm -ResourceGroupName $rgName
#Update-AzVM -VM $vm -ResourceGroupName $rgName

# Update the storage type
$diskUpdateConfig = New-AzureRmDiskUpdateConfig -DiskSizeGB $disk.DiskSizeGB -SkuName $storageType
Update-AzureRmDisk -DiskUpdate $diskUpdateConfig -ResourceGroupName $rgName -DiskName $disk.Name

#$diskUpdateConfig = New-AzDiskUpdateConfig -AccountType $storageType -DiskSizeGB $disk.DiskSizeGB
#Update-AzDisk -DiskUpdate $diskUpdateConfig -ResourceGroupName $rgName `
#-DiskName $disk.Name

Start-AzureRmVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name
#Start-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name
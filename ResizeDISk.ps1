$rgName = 'DEM-01'
$diskName = 'disk001'

# Get the managed Disk using the Name  
$disk = Get-AzureRmDisk -DiskName $diskName -ResourceGroupName $rgName

# get the Virtual machine using the Disk
$vmResource = Get-AzureRmResource -ResourceId $disk.ManagedBy

# Stopping the VM
Stop-AzureRmVM -ResourceGroupName $vmResource.ResourceGroupName -Name $vmResource.Name -Force

$disk.DiskSizeGB = 258

# sleep time of 15 seconds so that the VM is stopped before proceeding
Start-Sleep -s 15   

# update the disk configuration
Update-AzureRMDisk -ResourceGroupName $rgName -Disk $disk -DiskName $disk.Name

# starting the VM again
Start-AzureRmVM -ResourceGroupName $vmResource.ResourceGroupName -Name $vmResource.Name

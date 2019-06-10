
$rgName = 'GAV-ARV-DR-DEM-01'
$diskName = ''

$disk = Get-AzureRmDisk -DiskName $diskName -ResourceGroupName $rgName

$vmResource = Get-AzureRmResource -ResourceId $disk.ManagedBy

Stop-AzureRmVM -ResourceGroupName $vmResource.ResourceGroupName -Name $vmResource.Name -Force

$disk.DiskSizeGB = 258

Start-Sleep -s 15

Update-AzureRMDisk -ResourceGroupName $rgName -Disk $disk -DiskName $disk.Name

Start-AzureRmVM -ResourceGroupName $vmResource.ResourceGroupName -Name $vmResource.Name




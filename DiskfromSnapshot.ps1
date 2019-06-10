
$snapshot = Get-AzureRmSnapshot -ResourceGroupName GAV-ARV-DR-DEM-01 -SnapshotName snapshot0 -Verbose


#New-AzureRmDiskConfig 
$diskConfig = New-AzureRmDiskConfig -Location westus -SourceResourceId $snapshot.Id -CreateOption Copy;
New-AzureRmDisk -Disk $diskConfig -ResourceGroupName GAV-ARV-DR-DEM-01 -DiskName testvmdisk1;

#-AccountType $storageType
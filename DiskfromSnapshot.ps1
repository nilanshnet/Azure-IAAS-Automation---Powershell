$rgName = "rgName"
$Snapshotname = "snp001"
$NewdiskName = "vdddd"

$snapshot = Get-AzureRmSnapshot -ResourceGroupName $rgName -SnapshotName $Snapshotname -Verbose

#New-AzureRmDiskConfig 
$diskConfig = New-AzureRmDiskConfig -Location westus -SourceResourceId $snapshot.Id -CreateOption Copy;
New-AzureRmDisk -Disk $diskConfig -ResourceGroupName $rgName -DiskName $NewdiskName ;

#-AccountType $storageType

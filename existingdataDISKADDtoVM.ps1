Clear-Host

$Subscription_ID = "63f2f6e3-89a1-4677-a780-2f788788f101"
$rgName = "GAV-ARV-DR-DEM-01"
$location = "West US" 

$dataDiskNames = @("datademodisk1","datademodisk2","datademodisk3","datademodisk4","datademodisk5")

#$disk = Get-AzDisk -ResourceGroupName $rgName -DiskName $dataDiskName 
$vm = Get-AzureRmVM -Name $vmName -ResourceGroupName $rgName
$lun = 0 
foreach($dataDiskName in $dataDiskNames)
{
$disk = Get-AzureRmDisk -ResourceGroupName $rgName -DiskName $dataDiskName

#$vm = Get-AzVM -Name $vmName -ResourceGroupName $rgName 

$vm = Add-AzVMDataDisk -CreateOption Attach -Lun $lun -VM $vm -ManagedDiskId $disk.Id

#Update-AzVM -VM $vm -ResourceGroupName $rgName
$lun++
}

Update-AzureRmVM -VM $vm -ResourceGroupName $rgName 
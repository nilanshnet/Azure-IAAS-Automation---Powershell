Login-AzureRmAccount

$resourceGroupName = "GEN-01"  #"Input the name of the Resource Group where the VM is present "
$vmName= "001"    #"Input the name for the VM "
$Location = "westus"   #"Input the Location "
$destresourceGroupName = "P-01"  #destination Resource Group for the SnapShots with the TIMESTAMP 
$subscriptionID = "XXXXXXXXXXXXXXXXXXXXXXXXXXXX01"

Select-AzureRmSubscription -Subscription $subscriptionID

#Getting the VM
$vm = Get-AzureRmVM -ResourceGroupName $resourceGroupName -Name $vmName
Write-Host "VM details `n" -ForegroundColor Green -BackgroundColor Black
$vm

# Giving the user prompt to input the option slection of Snapshot creation for either for all DISKS or just the Data disks

$caption="SNAPSHOTS"
$message="CREATE SNAPSHOTS FOR :"
$choices = @("&DATA DISKS","&ALL DISKS")

$choicedesc = New-Object System.Collections.ObjectModel.Collection[System.Management.Automation.Host.ChoiceDescription] 
$choices | foreach  { $choicedesc.Add((New-Object "System.Management.Automation.Host.ChoiceDescription" -ArgumentList $_))} 


$prompt = $Host.ui.PromptForChoice($caption, $message, $choicedesc, 0)

Switch ($prompt)
     {
       0 {
            $vmDataDisks=(Get-AzureRmVM -ResourceGroupName $resourceGroupName -Name $vmName).StorageProfile.DataDisks
            if (-Not $vmDataDisks){
            Write-Host "No data disks for this VM" -ErrorAction Stop 
            }
            foreach($vmDisk in $vmDataDisks)
            {
            $vmDiskName = $vmDisk.Name
            $diskID = "/subscriptions/$subscriptionID/resourceGroups/$resourceGroupName/providers/Microsoft.Compute/disks/$vmDiskName"
            $SnapshotConfig = New-AzureRmSnapshotConfig -SourceUri $diskID -CreateOption Copy -Location $Location
            $timestamp = Get-Date -Format MM-dd-yyyy_HH:mm:ss | foreach {$_ -replace ":", "-"}
            $ddsnapshotname = "Snapshot_" + $vmDiskName + "_$timestamp"
            $Snapshot=New-AzureRmSnapshot -Snapshot $snapshotConfig -SnapshotName `
            $ddsnapshotname -ResourceGroupName $destresourceGroupName
            Write-Host "Snapshot Created for Data Disk-$vmDiskName as $ddsnapshotname" -ForegroundColor Green -BackgroundColor Black 
            
            }
         }
       1 { 

            $vmDisks=(Get-AzureRmVM -ResourceGroupName $resourceGroupName -Name $vmName).StorageProfile.OsDisk
            
            foreach($vmDisk in $vmDisks)
            {
            $vmDiskName = $vmDisk.Name
            $diskID = "/subscriptions/$subscriptionID/resourceGroups/$resourceGroupName/providers/Microsoft.Compute/disks/$vmDiskName"
            $SnapshotConfig = New-AzureRmSnapshotConfig -SourceUri $diskID -CreateOption Copy -Location $Location
            $timestamp = Get-Date -Format MM-dd-yyyy_HH:mm:ss | foreach {$_ -replace ":", "-"}
            $odsnapshotname = "OS_Snapshot_" + $vmDiskName + "_$timestamp"
            $Snapshot = New-AzureRmSnapshot -Snapshot $snapshotConfig -SnapshotName `
            $odsnapshotname -ResourceGroupName $destresourceGroupName
            
            Write-Host "Snapshot Created for OS Disk-$vmDiskName as $odsnapshotname" -ForegroundColor Green -BackgroundColor Black
            }

            $vmDataDisks=(Get-AzureRmVM -ResourceGroupName $resourceGroupName -Name $vmName).StorageProfile.DataDisks
            if (-Not $vmDataDisks)
            {
            Write-Host "No data disks for this VM" -ErrorAction Continue 
            }
            foreach($vmDisk in $vmDataDisks)
            {
            $vmDiskName = $vmDisk.Name
            $vmresourcegroupname = $vmDisk.ResourceGroupName
            $Disk = Get-AzureRmDisk -DiskName $vmDiskName -ResourceGroupName $vmresourcegroupname  
            $SnapshotConfig = New-AzureRmSnapshotConfig -SourceUri $diskID -CreateOption Copy -Location $Location
            $timestamp = Get-Date -Format MM-dd-yyyy_HH:mm:ss | foreach {$_ -replace ":", "-"}
            $ddsnapshotname = "Snapshot_" + $vmDiskName + "_$timestamp"
            $Snapshot=New-AzureRmSnapshot -Snapshot $snapshotConfig -SnapshotName `
            $ddsnapshotname -ResourceGroupName $destresourceGroupName
            Write-Host "Snapshot Created for Data Disk-$vmDiskName as $ddsnapshotname" -ForegroundColor Green -BackgroundColor Black 
            
        }

     }
}




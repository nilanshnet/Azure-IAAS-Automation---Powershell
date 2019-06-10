$stgaccname  # existing storage account
$containerName # name of the container within the Storage account
$rgname # name of the storage account

$stgacc = Get-AzureRmStorageAccount -ResourceGroupName $rgname -Name $stgaccname 
$stgacc | Get-AzureStorageContainer -Name $containerName | Set-AzureStorageContainerAcl -Permission Blob

$stgaccname = $stgacc.StorageAccountName
$rgname = $stgacc.ResourceGroupName
$filename = @("SRF.ps1")

Set-AzureRmVMCustomScriptExtension -ContainerName $containerName -Location "eastus" -FileName $filename `
-StorageAccountName $stgaccname -ResourceGroupName $rgname -VMName $vmname -Name $VMextensionName

<#
# code for azure devops

$stgacc = Get-AzureRmStorageAccount -ResourceGroupName "POC" -Name "pocstgacc001" 
$stgacc | Get-AzureStorageContainer -Name "srf" | Set-AzureStorageContainerAcl -Permission Blob

$stgaccname = $stgacc.StorageAccountName
$rgname = $stgacc.ResourceGroupName
$filename = @("SRF.ps1")
$vmname = "arvdrjmp001"

Set-AzureRmVMCustomScriptExtension -ContainerName "srf" -Location "eastus" -FileName $filename `
-StorageAccountName "pocstgacc001" -ResourceGroupName "poc" -VMName $vmname -Name "srf"


Write-Output ("##vso[task.setvariable variable=vmname;]$vmname")
#>

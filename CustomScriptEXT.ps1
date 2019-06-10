
$stgacc = Get-AzureRmStorageAccount -ResourceGroupName "POC" -Name "pocstgacc001" 
$stgacc | Get-AzureStorageContainer -Name "srf" | Set-AzureStorageContainerAcl -Permission Blob

$stgaccname = $stgacc.StorageAccountName
$rgname = $stgacc.ResourceGroupName
$filename = @("SRF.ps1")

Set-AzureRmVMCustomScriptExtension -ContainerName "srf" -Location "eastus" -FileName $filename `
-StorageAccountName "pocstgacc001" -ResourceGroupName "poc" -VMName "arvdrjmp001" -Name "srf"

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
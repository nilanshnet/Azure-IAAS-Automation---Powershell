#Connect-AzAccount

$ResourceGroupName = Read-Host "Enter Resource Group Name of your Storage Account"
$name = Read-Host "Enter Storage Account name"

$storageAccount = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $name

#$storageAccount = Get-AzStorageAccount | Out-GridView -PassThru -Title "Select your Azure Storage Account"


$i=Read-Host "Enter Blob/FileShare/Table/Queue "

switch ($i.ToLower())
{
    blob {
          $ctx = $storageAccount.Context
          $containerName = Read-Host "Enter Container Name"
          New-AzStorageContainer -Name $containerName -Context $ctx -Permission blob ; Break
          }
    
    fileshare {
          $ShareName = Read-Host "Enter Share name"
          New-AzStorageShare -Name $shareName -Context $ctx ; Break 
          }
               
    table {
          $TableName = Read-Host "Enter Table name"
          New-AzStorageTable -Name $tableName -Context $ctx  ; Break 
          }

    queue {
          $QueueName = Read-Host "Enter Queue Name" 
          New-AzStorageQueue -Name $QueueName -Context $ctx ; Break 
          }
    
}
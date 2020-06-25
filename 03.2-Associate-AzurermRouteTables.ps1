<#
.NOTES 
    File Name  : New-UDR.ps1
               :
    Author     : Charles Long - charlesl@hanu.com
               :
    Created    : 04/16/2019 v1.0
	Updated	   : MM/DD/2017 v1.1
                 
                 
#>

Select-AzureRmSubscription -SubscriptionName "HCAUK - Division"

$loc = 'UK South'
$rg = 'hcauks-prod-hub01-rg'
$vnetname = 'hcauks-prod-hub01-vnet'
$SubnetName = 'prod-hub01-fw-int-vnet'

$RouteTableName = "$SubnetName-udr" 
$RouteTable = Get-AzureRmRouteTable -Name $RouteTableName -ResourceGroupName $rg
$Vnet = Get-AzureRmVirtualNetwork -Name $vnetname -ResourceGroupName $rg
$Subnet = $vnet.Subnets | Where-Object Name -eq $subnetName

Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $Vnet -Name $SubnetName -AddressPrefix $Subnet.AddressPrefix -RouteTableId $RouteTable.Id | Set-AzureRmVirtualNetwork
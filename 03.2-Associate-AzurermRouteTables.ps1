<#
.NOTES 
    File Name  : New-UDR.ps1
               :
    Author     : Nilansh Netan - nil.netan963@gmail.com
               :
    Created    : 04/16/2020 v1.0
                 
#>

Select-AzureRmSubscription -SubscriptionName ""

$loc = 'East US'
$rg = 'prod-hub01-rg'
$vnetname = 'prod-hub01-vnet'
$SubnetName = 'prod-hub01-fw-int-vnet'

$RouteTableName = "$SubnetName-udr" 
$RouteTable = Get-AzureRmRouteTable -Name $RouteTableName -ResourceGroupName $rg
$Vnet = Get-AzureRmVirtualNetwork -Name $vnetname -ResourceGroupName $rg
$Subnet = $vnet.Subnets | Where-Object Name -eq $subnetName

Set-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $Vnet -Name $SubnetName -AddressPrefix $Subnet.AddressPrefix -RouteTableId $RouteTable.Id | Set-AzureRmVirtualNetwork

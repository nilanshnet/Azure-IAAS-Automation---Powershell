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

$rg = 'hcauks-prod-hub01-rg'
$vnetname = 'hcauks-prod-hub01-vnet'
$loc = 'UK South'


$Route = New-AzureRmRouteConfig -name "default.route" -AddressPrefix "0.0.0.0/0" -NextHopType VirtualAppliance -NextHopIpAddress "10.120.16.121"
New-AzureRmRouteTable -Name "$vnetname-udr" -ResourceGroupName $rg -Location $loc -Route $Route


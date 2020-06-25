<#
.NOTES 
    File Name  : New-UDR.ps1
               :
    Author     : Nilansh Netan - nil.netan963@gmail.com
               :
    Created    : 04/16/2020 v1.0

                 
                 
#>

Select-AzureRmSubscription -SubscriptionName ""

$rg = 'prod-hub01-rg'
$vnetname = 'prod-hub01-vnet'
$loc = 'East US'


$Route = New-AzureRmRouteConfig -name "default.route" -AddressPrefix "0.0.0.0/0" -NextHopType VirtualAppliance -NextHopIpAddress "10.120.16.121"
New-AzureRmRouteTable -Name "$vnetname-udr" -ResourceGroupName $rg -Location $loc -Route $Route


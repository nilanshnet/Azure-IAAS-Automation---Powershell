<# 
		$ResourceGroupName		- Default resource group
		$Location			- Azure DC
		$VMName				- VM Name
		$OSDiskUri			- path to the existing VHD 
		$VMSize				- How big is this badboy going to be

		$SubnetName			- Name of Subnet
		$InterfaceName 			- NIC name.  If using existing NIC, match the name
		$VNetName 			- Network Name
		$VNetResourceGroupName 		- Resource Group where network resources live.  May be different than the other resources 

#>

$ResourceGroupName = "rg-nil"
$Location = "EastUS"

# Compute Variables
$VMName = "ADFS-1"
$OSDiskUri = "https://tailstorageaccount.blob.core.windows.net/vhds/niltest.vhd"
$VMSize = "Standard_A1"
$OSDiskName = $VMName
$VMResourceGroupName = "rg-nil"
$VMAvailabilitySetName = "nil-AvaSet"

# Network Variables
$SubnetName = "Subnet-1"
$InterfaceName = $VMName + "-PrimaryNic"
$VNetName = "vnet"
$VNetResourceGroupName = "rg-nil"

# Network Script
$VNet   = Get-AzureRMVirtualNetwork -Name $VNetName -ResourceGroupName $VNetResourceGroupName
$Subnet = Get-AzureRMVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VNet

# Create the Interface
$Interface  = New-AzureRMNetworkInterface -Name $InterfaceName -ResourceGroupName $ResourceGroupName -Location $Location -SubnetId $Subnet.Id
# Use an existing interface
#$Interface = Get-AzureRMNetworkInterface -Name $InterfaceName -ResourceGroupName $ResourceGroupName  


# Compute Script 
$AvailabilitySet = Get-AzureRmAvailabilitySet -ResourceGroupName $VMResourceGroupName  -Name $VMAvailabilitySetName
$VirtualMachine  = New-AzureRMVMConfig -VMName $VMName -VMSize $VMSize -AvailabilitySetID $AvailabilitySet.Id
$VirtualMachine  = Add-AzureRMVMNetworkInterface -VM $VirtualMachine -Id $Interface.Id
$VirtualMachine  = Set-AzureRMVMOSDisk -VM $VirtualMachine -Name $OSDiskName -VhdUri $OSDiskUri -CreateOption Attach -Windows


# Create the VM in Azure
New-AzureRMVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $VirtualMachine



<#
.SYNOPSIS
	Removes a Bluetooth device
.DESCRIPTION
	This PowerShell script removes a Bluetooth device from the local computer.
.EXAMPLE
	PS> ./remove-bluetooth-device.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

$Source = @"
	[DllImport("BluetoothAPIs.dll", SetLastError = true, CallingConvention = CallingConvention.StdCall)]
	[return: MarshalAs(UnmanagedType.U4)]
	static extern UInt32 BluetoothRemoveDevice(IntPtr pAddress);
	public static UInt32 Unpair(UInt64 BTAddress) {
		GCHandle pinnedAddr = GCHandle.Alloc(BTAddress, GCHandleType.Pinned);
		IntPtr pAddress     = pinnedAddr.AddrOfPinnedObject();
		UInt32 result       = BluetoothRemoveDevice(pAddress);
		pinnedAddr.Free();
		return result;
	}
"@

function Get-BTDevice {
	Get-PnpDevice -class Bluetooth |
		?{$_.HardwareID -match 'DEV_'} |
			select Status, Class, FriendlyName, HardwareID,
				# Extract device address from HardwareID
				@{N='Address';E={[uInt64]('0x{0}' -f $_.HardwareID[0].Substring(12))}}
}

try {
	"⏳ Querying Bluetooth devices..."
	$BTR       = Add-Type -MemberDefinition $Source -Name "BTRemover"  -Namespace "BStuff" -PassThru
	$BTDevices = @(Get-BTDevice) # Force array if null or single item
	if ($BTDevices.Count -eq 0) { throw "No Bluetooth devices found" }

	do {
		if ($BTDevices.Count) {
			for ($i=0; $i -lt $BTDevices.Count; $i++) {
				('{0,5} - {1} ({2}/{3}/{4})' -f ($i+1), $BTDevices[$i].FriendlyName, $BTDevices[$i].Status, $BTDevices[$i].Class, $BTDevices[$i].Address) | Write-Host
			}
			$selected = Read-Host "`nSelect a device to remove (0 to Exit)"
			If ([int]$selected -in 1..$BTDevices.Count) {
				'Removing device: {0}' -f $BTDevices[$Selected-1].FriendlyName | Write-Host
				$Result = $BTR::Unpair($BTDevices[$Selected-1].Address)
				If (!$Result) {
					"Device removed successfully." | Write-Host
				} Else {
					("Sorry, an error occured. Return was: {0}" -f $Result) | Write-Host
				}
			}
		} else {
			"No more Bluetooth devices found"
		}
	} while (($BTDevices = @(Get-BTDevice)) -and [int]$selected)
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}

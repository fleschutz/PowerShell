<#
.SYNOPSIS
	Checks BIOS details
.DESCRIPTION
	This PowerShell script queries BIOS details and prints it.
.EXAMPLE
	PS> ./check-bios
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		# TODO
	} else {
		$BIOS = Get-CimInstance -ClassName Win32_BIOS
		$Manufacturer = $BIOS.Manufacturer
		$Model = $BIOS.Name
		$SerialNumber = $BIOS.SerialNumber
		$Version = $BIOS.Version
		"✅ BIOS $Manufacturer $($Model): S/N $SerialNumber, version $Version"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
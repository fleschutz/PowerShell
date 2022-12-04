<#
.SYNOPSIS
	Checks BIOS details
.DESCRIPTION
	This PowerShell script queries BIOS details and prints it.
.EXAMPLE
	PS> ./check-bios
	✅ BIOS V1.10 by INSYDE Corp. (S/N NXA82EV0EBB07600, version ACRSYS - 2)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Write-Progress "Querying BIOS details..."
	if ($IsLinux) {
		# TODO
	} else {
		$BIOS = Get-CimInstance -ClassName Win32_BIOS
		$Manufacturer = $BIOS.Manufacturer
		$Model = $BIOS.Name
		$Serial = $BIOS.SerialNumber
		$Version = $BIOS.Version
		"✅ BIOS $Model by $Manufacturer (S/N $Serial, version $Version)"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
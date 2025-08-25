<#
.SYNOPSIS
	Adds firewall rules for executables (needs admin rights).
.DESCRIPTION
	This PowerShell script adds firewall rules for the given executable. Administrator rights are required.
.PARAMETER PathToExecutables
	Specifies the path to the executables.
.PARAMETER Direction
	Specifies the direction for the firewall rule. Can be 'Inbound' or 'Outbound'. Default is 'Inbound'.
.PARAMETER Profile 
	Specifies the firewall profile. Can be 'Domain', 'Private', or 'Public'. Multiple values can be specified as an array.
.EXAMPLE
	PS> ./add-firewall-rules.ps1 -PathToExecutables C:\MyApp\bin -Direction Outbound -Profile Private
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#Requires -RunAsAdministrator

param(
	[string]$PathToExecutables = "",
	[string]$Direction = "Inbound",
	[array]$FirewallProfile  = @("Domain", "Private")
)

try {
	if (-not $PathToExecutables) {
		$PathToExecutables = Read-Host "Enter path to executables"
	}

	$AbsPath = Convert-Path -Path $PathToExecutables
	$Executables = Get-ChildItem -Path $AbsPath -Filter "*.exe"

	if (-not $Executables) {
		Write-Warning "No executables found. No Firewall rules have been created."
		Read-Host "Press Enter to continue..."
		return
	}

	foreach ($exe in $Executables) {
		$exeName = $exe.Name
		$exeFullPath = $exe.FullName

		Write-Output "Adding firewall rule for $exeName"
		New-NetFirewallRule -DisplayName $exeName -Direction $Direction -Program $exeFullPath -Profile $FirewallProfile  -Action Allow
	}

	Write-Host -ForegroundColor Green "Done"
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}


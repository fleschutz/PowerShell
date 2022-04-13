<#
.SYNOPSIS
	Adds firewall rules for executables (needs admin rights)
.DESCRIPTION
	This PowerShell script adds firewall rules for the given executable. Administrator rights are required.
.PARAMETER PathToExecutables
	Specifies the path to the executables
.EXAMPLE
	PS> ./add-firewall-rules C:\MyApp\bin
	Adding firewall rule for C:\MyApp\bin\app1.exe
	Adding firewall rule for C:\MyApp\bin\app2.exe
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

#Requires -RunAsAdministrator

param([string]$PathToExecutables = "")

$command = '
$output = ''Firewall rules for path '' + $args[0]
write-output $output
for($i = 1; $i -lt $args.count; $i++){
	$path = $args[0]
	$path += ''\''
	$path += $args[$i]

	$null = $args[$i] -match ''[^\\]*\.exe$''
	$name = $matches[0]
    $output = ''Adding firewall rule for '' + $name
	write-output $output
	$null = New-NetFirewallRule -DisplayName $name -Direction Inbound -Program $path -Profile Domain, Private -Action Allow
}
write-host -foregroundColor green -noNewline ''Done - press any key to continue...'';
[void]$Host.UI.RawUI.ReadKey(''NoEcho,IncludeKeyDown'');
'


try {
	if ($PathToExecutables -eq "" ) {
		$PathToExecutables = read-host "Enter path to executables"
	}

	$PathToExecutables = Convert-Path -Path $PathToExecutables

	$Apps = Get-ChildItem "$PathToExecutables\*.exe" -Name

	if($Apps.count -eq 0){
		write-warning "No executables found. No Firewall rules have been created."
		Write-Host -NoNewhLine 'Press any key to continue...';
		[void]$Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
		exit 1
	}

	$arg = "PathToExecutables $Apps"
	Start-Process powershell -Verb runAs -ArgumentList "-command & {$command}  $arg"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}

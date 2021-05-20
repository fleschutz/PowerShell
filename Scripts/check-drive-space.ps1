<#
.SYNTAX       check-drive-space.ps1 [<drive>] [<min-level>]
.DESCRIPTION  checks the given drive for free space left
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Drive = "", [int]$MinLevel = 20) # minimum level in GB

if ($Drive -eq "" ) { $Drive = read-host "Enter drive to check" }

try {
	$DriveDetails = (get-psdrive $Drive)
	[int]$Free = (($DriveDetails.Free / 1024) / 1024) / 1024
	[int]$Used = (($DriveDetails.Used / 1024) / 1024) / 1024
	[int]$Total = ($Used + $Free)

	if ($Free -lt $MinLevel) {
        	write-warning "Drive $Drive has only $Free GB left to use! ($Used GB out of $Total GB in use, minimum is $MinLevel GB)"
		exit 1
	}
	"✔️ $Free GB left on drive $Drive ($Used GB of $Total GB used)"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}

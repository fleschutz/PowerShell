#!/snap/bin/powershell
<#
.SYNTAX         ./smart-data2csv.ps1 [<wildcard>]
.DESCRIPTION	converts the given S.M.A.R.T. data (.json) to a CSV table
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Wildcard = "")

function WriteCsvHeader { param([PSCustomObject]$File) 
	for ([int]$i = 0; $i -lt 20; $i++) {
		$ID = $File.ata_smart_attributes.table[$i].id
		$Name = $File.ata_smart_attributes.table[$i].name
		write-host -nonewline "$ID ($Name);"
	}
	write-host ""
}

function WriteCsvRow { param([PSCustomObject]$File) 
	for ([int]$i = 0; $i -lt 20; $i++) {
		$ID = $File.ata_smart_attributes.table[$i].id
		$Value = $File.ata_smart_attributes.table[$i].value
		write-host -nonewline "$Value;"
	}
	write-host ""
}

try {
	if ($Wildcard -eq "" ) {
		$Wildcard = read-host "Enter path to S.M.A.R.T data (.json file)"
	}

	$Filenames = get-childitem -path $Wildcard
	$ModelFamily = $ModelName = $SerialNumber = ""

	foreach($Filename in $Filenames) {
		$File = get-content $Filename | ConvertFrom-Json

		if ($File.model_family -ne $ModelFamily) {
			if ($ModelFamily -eq "") {
				$ModelFamily = $File.model_family
			} else {
				write-error "Different model families: $ModelFamily vs. $($File.model_family)"
				exit 1
			}
		}
		if ($File.model_name -ne $ModelName) {
			if ($ModelName -eq "") {
				$ModelName = $File.model_name
			} else {
				write-error "Different model names: $ModelName vs. $($File.model_name)"
				exit 1
			}
		}
		if ($File.serial_number -ne $SerialNumber) {
			if ($SerialNumber -eq "") {
				$SerialNumber = $File.serial_number
			} else {
				write-error "Different serial numbbers: $SerialNumber vs. $($File.serial_number)"
				exit 1
			}
		}

		WriteCsvHeader $File
		WriteCsvRow $File
	}
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}

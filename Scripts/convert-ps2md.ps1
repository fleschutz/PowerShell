<#
.SYNOPSIS
	convert-ps2md.ps1 [<script>]
.DESCRIPTION
	Converts the comment-based help of a PowerShell script to Markdown
.EXAMPLE
	PS> .\convert-ps2md.ps1 myscript.ps1
.NOTES
	Author:  Markus Fleschutz
	License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$script)

function EncodePartOfHtml {
    param (
        [string]
        $Value
    )

    ($Value -replace '<', '&lt;') -replace '>', '&gt;'
}

function GetCode {
    param (
        $Example
    )
    $codeAndRemarks = (($Example | Out-String) -replace ($Example.title), '').Trim() -split "`r`n"

    $code = New-Object "System.Collections.Generic.List[string]"
    for ($i = 0; $i -lt $codeAndRemarks.Length; $i++) {
        if ($codeAndRemarks[$i] -eq 'DESCRIPTION' -and $codeAndRemarks[$i + 1] -eq '-----------') {
            break
        }
        if (1 -le $i -and $i -le 2) {
            continue
        }
        $code.Add($codeAndRemarks[$i])
    }

    $code -join "`r`n"
}

function GetRemark {
    param (
        $Example
    )
    $codeAndRemarks = (($Example | Out-String) -replace ($Example.title), '').Trim() -split "`r`n"

    $isSkipped = $false
    $remark = New-Object "System.Collections.Generic.List[string]"
    for ($i = 0; $i -lt $codeAndRemarks.Length; $i++) {
        if (!$isSkipped -and $codeAndRemarks[$i - 2] -ne 'DESCRIPTION' -and $codeAndRemarks[$i - 1] -ne '-----------') {
            continue
        }
        $isSkipped = $true
        $remark.Add($codeAndRemarks[$i])
    }

    $remark -join "`r`n"
}

try {
	$full = Get-Help $script -Full

	"# $($full.Name)"
	"$($full.Synopsis)"

	$Description = ($full.description | Out-String).Trim()
	if ($Description -ne "") {
		""
		"## Description"
		"$Description"
	}

	$Syntax = (($full.syntax | Out-String) -replace "`r`n", "`r`n`r`n").Trim()
	if ($Syntax -ne "") {
		""
		"## Syntax"
		"``````powershell"
		"$Syntax"
		"``````"
	}
@"


## Parameters
"@ + $(foreach ($parameter in $full.parameters.parameter) {
@"

### -$($parameter.name) &lt;$($parameter.type.name)&gt;
$(($parameter.description | Out-String).Trim())
``````
$(((($parameter | Out-String).Trim() -split "`r`n")[-5..-1] | % { $_.Trim() }) -join "`r`n")
``````

"@
}) + @"

## Inputs
$($full.inputTypes.inputType.type.name)

## Outputs

## Examples
"@ + $(foreach ($example in $full.examples.example) {
@"

### $(($example.title -replace '-*', '').Trim())
``````powershell
$(GetCode $example)
``````
$(GetRemark $example)

"@
}) + @"

"@
	$Notes = ($full.alertSet.alert | Out-String).Trim()
	if ($Notes -ne "") {
		""
		"## Notes"
		"$Notes"
	}

	$Links = ($full.relatedlinks | Out-String).Trim()
	if ($Links -ne "") {
		""
		"## Related Links"
		"$Links"
	}

} finally {
}

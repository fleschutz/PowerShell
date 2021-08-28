# 
# File: Get-HelpByMarkdown.ps1
# 
# Author: Akira Sugiura (urasandesu@gmail.com)
# 
# 
# Copyright (c) 2014 Akira Sugiura
#  
#  This software is MIT License.
#  
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#  
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#  
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.
#

<#
    .SYNOPSIS
        Gets the comment-based help and converts to GitHub Flavored Markdown.

    .PARAMETER  Name
        A command name to get comment-based help.

    .EXAMPLE
        & .\Get-HelpByMarkdown.ps1 Select-Object > .\Select-Object.md
        
        DESCRIPTION
        -----------
        This example gets comment-based help of `Select-Object` command, and converts GitHub Flavored Markdown format, then saves it to `Select-Object.md` in current directory.

    .INPUTS
        System.String

    .OUTPUTS
        System.String

#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $True)]
    $Name
)

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
    if ($Host.UI.RawUI) {
      $rawUI = $Host.UI.RawUI
      $oldSize = $rawUI.BufferSize
      $typeName = $oldSize.GetType().FullName
      $newSize = New-Object $typeName (500, $oldSize.Height)
      $rawUI.BufferSize = $newSize
    }

    $full = Get-Help $Name -Full

@"
# $($full.Name)
## SYNOPSIS
$($full.Synopsis)

## SYNTAX
``````powershell
$((($full.syntax | Out-String) -replace "`r`n", "`r`n`r`n").Trim())
``````

## DESCRIPTION
$(($full.description | Out-String).Trim())

## PARAMETERS
"@ + $(foreach ($parameter in $full.parameters.parameter) {
@"

### -$($parameter.name) &lt;$($parameter.type.name)&gt;
$(($parameter.description | Out-String).Trim())
``````
$(((($parameter | Out-String).Trim() -split "`r`n")[-5..-1] | % { $_.Trim() }) -join "`r`n")
``````

"@
}) + @"

## INPUTS
$($full.inputTypes.inputType.type.name)

## OUTPUTS
$($full.returnValues.returnValue[0].type.name)

## NOTES
$(($full.alertSet.alert | Out-String).Trim())

## EXAMPLES
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

} finally {
    if ($Host.UI.RawUI) {
      $rawUI = $Host.UI.RawUI
      $rawUI.BufferSize = $oldSize
    }
}

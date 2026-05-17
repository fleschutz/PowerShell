The 'split-file.ps1' Script
========================

Split mode divides the source file into $PartCount roughly equal parts, saving each as
SplitFile1, SplitFile2, ... in the Parts\ subdirectory alongside the script. Two metadata
files (OriginalName.txt, OriginalSize.txt) are also saved there for use during Join.

Join mode reads the part files from Parts\, reassembles them into the original file in
Output\, then verifies the output size against the metadata saved during Split.

The -Clean flag deletes all files in Parts\ and Output\ and can be combined with -Mode.

FOLDER STRUCTURE
<script directory>\
    Split-File.ps1
    Parts\      (auto-created) Split part files and metadata are stored here
    Output\     (auto-created) Reassembled file is placed here

Parameters
----------
```powershell
PS> ./split-file.ps1 [[-Mode] <String>] [[-InputFile] <String>] [[-PartCount] <Int32>] [-Clean] [<CommonParameters>]

-Mode <String>
    Operation mode. Accepted values: "Split" or "Join".
    - Split : Divides -InputFile into -PartCount parts and saves metadata to Parts\.
    - Join  : Reads part files from Parts\ and reassembles them into Output\.
    At least one of -Mode or -Clean must be specified.
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-InputFile <String>
    Full path to the source file to be split. Required when -Mode is "Split".
    Example: "C:\WorkingDirectory\Source.ISO"
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-PartCount <Int32>
    Number of parts to split the file into. Must be 2 or greater. Default: 2.
    The file is divided into roughly equal parts; the last part may be slightly smaller.
    
    Required?                    false
    Position?                    3
    Default value                2
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-Clean [<SwitchParameter>]
    Deletes all files from Parts\ and Output\ before running.
    Can be used alone (clean without splitting or joining) or combined with -Mode.
    
    Required?                    false
    Position?                    named
    Default value                False
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS > .\Split-File.ps1 -Mode Split -InputFile "C:\WorkingDirectory\Source.ISO"
Splits Source.ISO into 2 equal parts (default) and saves them to Parts\.

```

Example
-------
```powershell
PS > .\Split-File.ps1 -Mode Split -InputFile "C:\WorkingDirectory\Source.ISO" -PartCount 4
Splits Source.ISO into 4 parts and saves them to Parts\.

```

Example
-------
```powershell
PS > .\Split-File.ps1 -Mode Split -InputFile "C:\WorkingDirectory\Source.ISO" -Clean
Clears Parts\ and Output\ first, then splits Source.ISO into 2 parts.

```

Example
-------
```powershell
PS > .\Split-File.ps1 -Mode Join
Reads part files from Parts\ and reassembles the original file into Output\.
The output filename is read automatically from Parts\OriginalName.txt.

```

Example
-------
```powershell
PS > .\Split-File.ps1 -Mode Join -Clean
Clears Output\ first, then reassembles the original file into Output\.

```

Example
-------
```powershell
PS > .\Split-File.ps1 -Clean
Deletes all files from Parts\ and Output\ without splitting or joining.

```

Notes
-----
Size verification:
    After joining, the output file size is compared against the size recorded during
    Split (Parts\OriginalSize.txt). A mismatch is reported as an error.

Requires -Version 3.0

Script Content
--------------
```powershell
<#
.SYNOPSIS
    Splits a large file into numbered parts, or joins them back together.
.DESCRIPTION
    Split mode divides the source file into $PartCount roughly equal parts, saving each as
    SplitFile1, SplitFile2, ... in the Parts\ subdirectory alongside the script. Two metadata
    files (OriginalName.txt, OriginalSize.txt) are also saved there for use during Join.

    Join mode reads the part files from Parts\, reassembles them into the original file in
    Output\, then verifies the output size against the metadata saved during Split.

    The -Clean flag deletes all files in Parts\ and Output\ and can be combined with -Mode.

  FOLDER STRUCTURE
    <script directory>\
        Split-File.ps1
        Parts\      (auto-created) Split part files and metadata are stored here
        Output\     (auto-created) Reassembled file is placed here

.PARAMETER Mode
    Operation mode. Accepted values: "Split" or "Join".
    - Split : Divides -InputFile into -PartCount parts and saves metadata to Parts\.
    - Join  : Reads part files from Parts\ and reassembles them into Output\.
    At least one of -Mode or -Clean must be specified.

.PARAMETER InputFile
    Full path to the source file to be split. Required when -Mode is "Split".
    Example: "C:\WorkingDirectory\Source.ISO"

.PARAMETER PartCount
    Number of parts to split the file into. Must be 2 or greater. Default: 2.
    The file is divided into roughly equal parts; the last part may be slightly smaller.

.PARAMETER Clean
    Deletes all files from Parts\ and Output\ before running.
    Can be used alone (clean without splitting or joining) or combined with -Mode.

.EXAMPLE
    .\Split-File.ps1 -Mode Split -InputFile "C:\WorkingDirectory\Source.ISO"
    Splits Source.ISO into 2 equal parts (default) and saves them to Parts\.

.EXAMPLE
    .\Split-File.ps1 -Mode Split -InputFile "C:\WorkingDirectory\Source.ISO" -PartCount 4
    Splits Source.ISO into 4 parts and saves them to Parts\.

.EXAMPLE
    .\Split-File.ps1 -Mode Split -InputFile "C:\WorkingDirectory\Source.ISO" -Clean
    Clears Parts\ and Output\ first, then splits Source.ISO into 2 parts.

.EXAMPLE
    .\Split-File.ps1 -Mode Join
    Reads part files from Parts\ and reassembles the original file into Output\.
    The output filename is read automatically from Parts\OriginalName.txt.

.EXAMPLE
    .\Split-File.ps1 -Mode Join -Clean
    Clears Output\ first, then reassembles the original file into Output\.

.EXAMPLE
    .\Split-File.ps1 -Clean
    Deletes all files from Parts\ and Output\ without splitting or joining.

.NOTES
    Size verification:
        After joining, the output file size is compared against the size recorded during
        Split (Parts\OriginalSize.txt). A mismatch is reported as an error.
#>
#Requires -Version 3.0
[CmdletBinding()]
param(
    [ValidateSet('Split', 'Join')]
    [string]$Mode,

    [string]$InputFile,

    [ValidateRange(2, [int]::MaxValue)]
    [int]$PartCount = 2,

    [switch]$Clean
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not $Mode -and -not $Clean) {
    throw "Specify -Mode (Split/Join) and/or -Clean. Run '.\Split-File.ps1 -?' for usage."
}

# Folder settings
$PartsDirectory  = Join-Path $PSScriptRoot 'Parts'
$OutputDirectory = Join-Path $PSScriptRoot 'Output'

# Buffer size: 100MB
$BufferSize = 100MB
$ReadBuffer = New-Object byte[] $BufferSize

if ($Clean) {
    foreach ($Directory in @($PartsDirectory, $OutputDirectory)) {
        if (Test-Path $Directory) {
            Remove-Item -Path (Join-Path $Directory '*') -Recurse -Force
            Write-Verbose "Cleaned: $Directory"
        }
    }
}

if ($Mode -eq 'Split') {

    if (-not $InputFile) {
        throw "-InputFile is required for Split mode."
    }

    if (-not (Test-Path $InputFile -PathType Leaf)) {
        throw "File not found: $InputFile"
    }

    $PartFileBasePath = Join-Path $PartsDirectory 'SplitFile'
    $SourceFileSize   = (Get-Item $InputFile).Length
    $PartSize         = [long][math]::Ceiling($SourceFileSize / $PartCount)

    if (-not (Test-Path $PartsDirectory)) {
        New-Item -ItemType Directory -Path $PartsDirectory | Out-Null
    }

    $SourceInputStream = [System.IO.File]::OpenRead($InputFile)
    try {
        for ($PartNumber = 1; $PartNumber -le $PartCount; $PartNumber++) {
            $PartFilePath     = "$PartFileBasePath$PartNumber"
            $PartOutputStream = [System.IO.File]::Create($PartFilePath)
            try {
                [long]$RemainingBytes = $PartSize

                while ($RemainingBytes -gt 0) {
                    [int]$BytesToRead = [Math]::Min([long]$BufferSize, $RemainingBytes)
                    $BytesRead = $SourceInputStream.Read($ReadBuffer, 0, $BytesToRead)

                    if ($BytesRead -eq 0) { break }

                    $PartOutputStream.Write($ReadBuffer, 0, $BytesRead)
                    $RemainingBytes -= $BytesRead
                }
            } finally {
                $PartOutputStream.Dispose()
            }

            Write-Verbose "Created: $PartFilePath"
        }
    } finally {
        $SourceInputStream.Dispose()
    }

    # Save original file size and name as metadata for join-time use
    $SourceFileSize               | Set-Content (Join-Path $PartsDirectory 'OriginalSize.txt') -Encoding ASCII
    (Split-Path -Leaf $InputFile) | Set-Content (Join-Path $PartsDirectory 'OriginalName.txt') -Encoding UTF8

    [PSCustomObject]@{
        InputFile = $InputFile
        PartCount = $PartCount
        PartsPath = $PartsDirectory
    }

} elseif ($Mode -eq 'Join') {

    # Read original filename from metadata saved during Split
    $OriginalNameMetaPath = Join-Path $PartsDirectory 'OriginalName.txt'
    if (-not (Test-Path $OriginalNameMetaPath)) {
        throw "OriginalName.txt not found. Run Split mode first."
    }
    $OriginalFileName = (Get-Content $OriginalNameMetaPath -Raw -Encoding UTF8).Trim()

    # Reject filenames that contain path separators to prevent writing outside OutputDirectory
    if ([System.IO.Path]::GetFileName($OriginalFileName) -ne $OriginalFileName) {
        throw "OriginalName.txt contains an unsafe filename: '$OriginalFileName'."
    }

    $JoinedFilePath = Join-Path $OutputDirectory $OriginalFileName

    if (-not (Test-Path $OutputDirectory)) {
        New-Item -ItemType Directory -Path $OutputDirectory | Out-Null
    }

    # Get split files sorted numerically by part number
    $PartFiles = Get-ChildItem -Path $PartsDirectory -File |
                 Where-Object { $_.Name -match '^SplitFile\d+$' } |
                 Sort-Object { [int]([regex]::Match($_.Name, '\d+$').Value) }

    if ($PartFiles.Count -eq 0) {
        throw "No part files found in the Parts folder."
    }

    Write-Verbose "Joining $($PartFiles.Count) part file(s)..."

    $JoinedOutputStream = [System.IO.File]::Create($JoinedFilePath)
    try {
        foreach ($PartFile in $PartFiles) {
            $PartInputStream = [System.IO.File]::OpenRead($PartFile.FullName)
            try {
                while (($BytesRead = $PartInputStream.Read($ReadBuffer, 0, [int]$BufferSize)) -gt 0) {
                    $JoinedOutputStream.Write($ReadBuffer, 0, $BytesRead)
                }
            } finally {
                $PartInputStream.Dispose()
            }

            Write-Verbose "Joined: $($PartFile.FullName)"
        }
    } finally {
        $JoinedOutputStream.Dispose()
    }

    # Verify output size against metadata
    $OriginalSizeMetaPath = Join-Path $PartsDirectory 'OriginalSize.txt'
    if (Test-Path $OriginalSizeMetaPath) {
        $OriginalFileSize = [long](Get-Content $OriginalSizeMetaPath -Raw -Encoding ASCII).Trim()
    } else {
        Write-Warning "OriginalSize.txt not found. Skipping size verification."
        $OriginalFileSize = $null
    }

    $ActualFileSize = (Get-Item $JoinedFilePath).Length

    if ($null -ne $OriginalFileSize -and $OriginalFileSize -ne $ActualFileSize) {
        Write-Error "Size mismatch: expected $OriginalFileSize bytes, got $ActualFileSize bytes."
    }

    [PSCustomObject]@{
        OutputFile   = $JoinedFilePath
        ActualSize   = $ActualFileSize
        ExpectedSize = $OriginalFileSize
        SizeMatch    = ($null -eq $OriginalFileSize -or $OriginalFileSize -eq $ActualFileSize)
    }
}
```

*(page generated by convert-ps2md.ps1 as of 05/17/2026 11:51:11)*

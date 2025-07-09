#requires -version 5.1

param(
    [string]$sourceFolder = ""
)

# If no parameter is given, prompt the user for the source folder
if (-not $sourceFolder) {
    $sourceFolder = Read-Host "Please enter the path to the source folder"
}

# Set the destination folder for fonts, you don't need to change this
$fontsFolder = "$env:SystemRoot\Fonts"

# Get all font files from the source folder
$fontFiles = Get-ChildItem -Path $sourceFolder -Filter *.ttf

foreach ($font in $fontFiles) {
    # Copy font files to the Fonts folder
    $destination = "$fontsFolder\$($font.Name)"
    Copy-Item -Path $font.FullName -Destination $destination -Force
    
    # Add font to registry
    $fontName = [System.IO.Path]::GetFileNameWithoutExtension($font.Name)
    $fontRegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
    
    # For TrueType fonts
    $fontType = "TrueType"
    
    # Add the registry entry
    New-ItemProperty -Path $fontRegistryPath -Name "$fontName ($fontType)" -PropertyType String -Value $font.Name -Force
}

Write-Output "Fonts have been installed successfully."

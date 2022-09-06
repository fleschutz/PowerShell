<#
.SYNOPSIS
	Lists all files and folder names matching a search pattern
.DESCRIPTION
	This PowerShell script serves as a quick Powershell replacement to the search functionality in Windows
	After you pass in a root folder and a search term, the script will list all files and folders matching that phrase.
.PARAMETER path
	Specifies the path 
.PARAMETER term
	Specifies the search term
.EXAMPLE
	PS> ./search-filename
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param(
[Parameter(Mandatory=$true)]
$path,
[Parameter(Mandatory=$true)]
$term
)
# Recursive search function
Write-Host "Results:"
function Search-Folder($FilePath, $SearchTerm) {
    # Get children
    $children = Get-ChildItem -Path $FilePath
    # For each child, see if it matches the search term, and if it is a folder, search it too.
    foreach ($child in $children) {
        $name = $child.Name
        if ($name -match $SearchTerm) {
            Write-Host "$FilePath\$name"
        }
        $isdir = Test-Path -Path "$FilePath\$name" -PathType Container
        if ($isdir) {
            Search-Folder -FilePath "$FilePath\$name" -SearchTerm $SearchTerm
        }
    }
}
# Call the search function
Search-Folder -FilePath $path -SearchTerm $term
exit 0 # success

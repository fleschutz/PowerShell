<#
.SYNOPSIS
	Verifies an XML file
.DESCRIPTION
	This PowerShell script checks the given XML file for validity.
.PARAMETER path
	Specifies the path to the XML file
.EXAMPLE
	PS> ./check-xml-file.ps1 myfile.xml
	✅ myfile.xml is valid XML
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "")

try {
	if ($path -eq "" ) { $path = Read-Host "Enter path to XML file" }

	$XmlFile = Get-Item $path
	
	# Perform the XSD Validation
	$script:ErrorCount = 0
	$ReaderSettings = New-Object -TypeName System.Xml.XmlReaderSettings
	$ReaderSettings.ValidationType = [System.Xml.ValidationType]::Schema
	$ReaderSettings.ValidationFlags = [System.Xml.Schema.XmlSchemaValidationFlags]::ProcessInlineSchema -bor [System.Xml.Schema.XmlSchemaValidationFlags]::ProcessSchemaLocation
	$ReaderSettings.add_ValidationEventHandler({ $script:ErrorCount++ })
	$ReaderSettings.DtdProcessing = [System.Xml.DtdProcessing]::Parse
	$Reader = [System.Xml.XmlReader]::Create($XmlFile.FullName, $ReaderSettings)
	while ($Reader.Read()) { }
	$Reader.Close()
	
	if ($script:ErrorCount -gt 0) {	throw "Invalid XML" } 

	"✅ $path is valid XML"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}

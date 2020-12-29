#!/snap/bin/powershell
<#
.SYNTAX         ./check-xml-file [<file>]
.DESCRIPTION	checks the given XML file for validity
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param ([String]$XmlFilePath)

try {
	if ($XmlFilePath -eq "" ) {
		$XmlFilePath = read-host "Enter path to XML file"
	}
	# Get the file
	$XmlFile = Get-Item($XmlFilePath)
	
	# Keep count of how many errors there are in the XML file
	$script:ErrorCount = 0
	
	# Perform the XSD Validation
	$ReaderSettings = New-Object -TypeName System.Xml.XmlReaderSettings
	$ReaderSettings.ValidationType = [System.Xml.ValidationType]::Schema
	$ReaderSettings.ValidationFlags = [System.Xml.Schema.XmlSchemaValidationFlags]::ProcessInlineSchema -bor [System.Xml.Schema.XmlSchemaValidationFlags]::ProcessSchemaLocation
	$ReaderSettings.add_ValidationEventHandler({ $script:ErrorCount++ })
	$Reader = [System.Xml.XmlReader]::Create($XmlFile.FullName, $ReaderSettings)
	while ($Reader.Read()) { }
	$Reader.Close()
	
	# Verify the results of the XSD validation
	if ($script:ErrorCount -gt 0) {
		write-output "XML file is NOT valid"
		exit 1
	} else {
		write-output "XML file is valid"
		exit 0
	}
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}

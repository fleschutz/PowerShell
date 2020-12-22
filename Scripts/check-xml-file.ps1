#!/snap/bin/powershell

# Syntax:       ./check-xml-file [<file>]
# Description:	checks the given XML file for validity
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

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
	write-warning "$($MyInvocation.MyCommand.Name) - Error: $($_.Exception.Message) - Line Number: $($_.InvocationInfo.ScriptLineNumber)"
	exit 1
}

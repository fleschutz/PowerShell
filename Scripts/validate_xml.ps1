function Validate-Xml {
	param ([string]$XmlFilePath)
	try {
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
			# XML is NOT valid
			$false
		} else {
			# XML is valid
			$true
		}
	} catch {
		Write-Warning "$($MyInvocation.MyCommand.Name) - Error: $($_.Exception.Message) - Line Number: $($_.InvocationInfo.ScriptLineNumber)"
	}
}

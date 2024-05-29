
try {
	& "$PSScriptRoot/open-default-browser.ps1" "https://docs.microsoft.com/en-us/powershell"
	Start-Sleep -milliseconds 100
	& "$PSScriptRoot/open-default-browser.ps1" "https://github.com/fleschutz/PowerShell/blob/main/docs/FAQ.md"
	Start-Sleep -milliseconds 100
	& "$PSScriptRoot/open-default-browser.ps1" "https://github.com/fleschutz/PowerShell/blob/main/docs/cheat-sheet.md"

	& "$PSScriptRoot/write-typewriter.ps1" "DON'T PANIC and check your brower tabs..."
        exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}
function Watch-File {

    Param(
        [Parameter(Mandatory=$false)]
        [ValidateSet('Created', 'Changed', 'Deleted', 'Renamed', 'Error')]
        [string]$event
    )
	
	# Define the path to the file you want to monitor
	$file = "C:\temp\file.txt"
	# Define the action that should be taken when the file changes
	
	
	$action = {
		switch ($event) {
		"Created" { Write-Host "File created" }
		"Changed" { Write-Host "File changed" }
		"Deleted" { Write-Host "File deleted" }
		"Renamed" { Write-Host "File renamed" }
		"Error" { Write-Host "Error" }			
		default { Write-Host "Sorry" }
		}
	}
	
	
	# Create a new FileSystemWatcher object
	$watcher = New-Object System.IO.FileSystemWatcher
	$watcher.Path = Split-Path -Path $file -Parent
	$watcher.Filter = Split-Path -Path $file -Leaf
	$watcher.IncludeSubdirectories = $false
	$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite -bor [System.IO.NotifyFilters]::FileName
	
	
	# Register the event watcher
	$watcher.EnableRaisingEvents = $true
	Register-ObjectEvent -InputObject $watcher -EventName $event -Action $action -SourceIdentifier FileChangedEvent
	
	
	# Keep the script running until the user stops it manually
	while ($true) {
		Start-Sleep -Seconds 1
	}
	# Unregister the event watcher
	Unregister-Event -SourceIdentifier FileChangedEvent
}
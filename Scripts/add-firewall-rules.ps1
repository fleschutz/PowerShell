#!/snap/bin/powershell
<#
.SYNTAX         ./add-firewall-rules.ps1 [<path-to-executables>]
.DESCRIPTION	adds firewall rules for the given executables, administrator rights are required
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

#Requires -RunAsAdministrator

param([string]$PathToExecutables)

$command = '
$output = ''Firewall rules for path '' + $args[0]
write-output $output
for($i = 1; $i -lt $args.count; $i++){
	$path = $args[0]
	$path += ''\''
	$path += $args[$i]

	$null = $args[$i] -match ''[^\\]*\.exe$''
	$name = $matches[0]
    $output = ''Adding firewall rule for '' + $name
	write-output $output
	$null = New-NetFirewallRule -DisplayName $name -Direction Inbound -Program $path -Profile Domain, Private -Action Allow
}
Write-Host -NoNewLine ''Done - press any key to continue...'';
$null = $Host.UI.RawUI.ReadKey(''NoEcho,IncludeKeyDown'');
'
#get current path
$path = get-location
$path = Convert-Path -Path $path
if(test-path "$path\executables"){
	#get all executables
	$Apps = @()
	$Apps += Get-ChildItem "$path\executables\*.exe" -Name

	for($i = 0; $i -lt $Apps.length; $i++){
		$Apps[$i] = "executables\" + $Apps[$i]
	}
    #Add 64bit Apps (if applicable)
	$Apps64 = @()
	if(test-path "$path\executables64"){
		#only try if 64bit executables are present
		$Apps64 += Get-ChildItem "$path\executables64\*.exe" -Name
		for($i = 0; $i -lt $Apps64.length; $i++){
			$Apps64[$i] = "executables64\" + $Apps64[$i]
		}
		$Apps += $Apps64
	}
    #Add all Java runtimes delivered
    $subdirs = get-childitem $path\jre
    foreach($item in $subdirs){
        if($item.PSIsContainer){
            $itempath = $item.BaseName
            $itempath += "\bin\javaw.exe"
            $itempath = "jre\$itempath"
            if(test-path("$path\$itempath")){
                $Apps += $itempath
            }
        }
    }

	if($Apps.count -eq 0){
		Write-Warning "No executables found. No Firewall rules have been created."
		Write-Host -NoNewhLine 'Press any key to continue...';
		$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	}else{
		$arg = "$path $Apps"
		Start-Process powershell -Verb runAs -ArgumentList "-command & {$command}  $arg"
	}
}else{
	write-warning "Cannot find executables path. The script must be executed in ATTower root directory"
	Write-Host -NoNewLine 'Press any key to continue...';
	$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}
exit 0

<#
.SYNOPSIS
	convert-sql2csv.ps1 [<server>] [<database>] [<username>] [<password>] [<query>]
.DESCRIPTION
	Converts a SQL database table to a .CSV file
.EXAMPLE
	PS> ./convert-sql2csv
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$server = "", [string]$database = "", [string]$username = "", [string]$password = "", [string]$query = "")

try {
	if ($server -eq "") { $server = read-host "Enter the hostname/IP address of the SQL server" }
	if ($database -eq "") { $database = read-host "Enter the database name" }
	if ($username -eq "") { $username = read-host "Enter the database username" }
	if ($password -eq "") { $password = read-host "Enter the database user password" }
	if ($query -eq "") { $query = read-host "Enter the database query" }

	$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
	$creds = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
	$csvfilepath = "$PSScriptRoot\sqlserver_table.csv"
	$result = Invoke-SqlServerQuery -Credential $creds -ConnectionTimeout 10000 -Database $database -Server $server -Sql $query -CommandTimeout 10000
	$result | Export-Csv $csvfilepath -NoTypeInformation
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}

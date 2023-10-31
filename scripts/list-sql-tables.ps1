<#
.SYNOPSIS
	Lists all tables of a SQL server database 
.DESCRIPTION
	This PowerShell script lists all tables in a SQL server database and exports the list as CSV.
	Install-Module InvokeQuery
	Run the above command if you do not have this module.
.EXAMPLE
	PS> ./list-sql-tables.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param(
[Parameter(Mandatory=$true)]$server,
[Parameter(Mandatory=$true)]$database,
[Parameter(Mandatory=$true)]$username,
[Parameter(Mandatory=$true)]$password
)
$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
$csvfilepath = "$PSScriptRoot\sqlserver_tables.csv"
$result = Invoke-SqlServerQuery -Credential $creds -ConnectionTimeout 10000 -Database $database -Server $server -Sql "SELECT TABLE_NAME FROM $database.INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'" -CommandTimeout 10000
$result | Export-Csv $csvfilepath -NoTypeInformation

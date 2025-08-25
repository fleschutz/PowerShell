<#
.SYNOPSIS
	Convert a MySQL database table to a .CSV file
.DESCRIPTION
	This PowerShell script converts a MySQL database table to a .CSV file.
.PARAMETER server
	Specifies the server's hostname or IP address
.PARAMETER database
	Specifies the database name
.PARAMETER username
	Specifies the user name
.PARAMETER password
	Specifies the password
.PARAMETER query
	Specifies the SQL query
.EXAMPLE
	PS> ./convert-mysql2csv.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>


param([string]$server = "", [string]$database = "", [string]$username = "", [string]$password = "", [string]$query = "")

try {
	if ($server -eq "") { $server = read-host "Enter the hostname/IP address of the MySQL server" }
	if ($database -eq "") { $database = read-host "Enter the database name" }
	if ($username -eq "") { $username = read-host "Enter the database username" }
	if ($password -eq "") { $password = read-host "Enter the database user password" }
	if ($query -eq "") { $query = read-host "Enter the database query" }

	$csvfilepath = "$PSScriptRoot\mysql_table.csv"
	$result = Invoke-MySqlQuery  -ConnectionString "server=$server; database=$database; user=$username; password=$password; pooling = false; convert zero datetime=True" -Sql $query -CommandTimeout 10000
	$result | Export-Csv $csvfilepath -NoTypeInformation
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}

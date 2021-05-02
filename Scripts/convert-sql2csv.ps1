<#
.SYNTAX       convert-sql2csv.ps1 [<server>] [<database>] [<username>] [<password>] [<query>]
.DESCRIPTION  convert the SQL database table to a CSV file
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($server = "", $database = "", $username = "", $password = "", $query = "")
if ($server -eq "") { $server = read-host "Enter the hostname/IP address of the SQL server" }
if ($database -eq "") { $database = read-host "Enter the database name" }
if ($username -eq "") { $username = read-host "Enter the database username" }
if ($password -eq "") { $password = read-host "Enter the database user password" }
if ($query -eq "") { $query = read-host "Enter the database query" }

try {
	$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
	$creds = New-Object System.Management.Automation.PSCredential ($username, $secpasswd)
	$csvfilepath = "$PSScriptRoot\sqlserver_table.csv"
	$result = Invoke-SqlServerQuery -Credential $creds -ConnectionTimeout 10000 -Database $database -Server $server -Sql $query -CommandTimeout 10000
	$result | Export-Csv $csvfilepath -NoTypeInformation
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}

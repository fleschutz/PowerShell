$a = Get-NetIPAddress | Where-Object -FilterScript { $_.SuffixOrigin -eq "DHCP" -or  $_.SuffixOrigin -eq "manual" } # | Format-Table -property IPAddress -autoSize

$arguments = "-sT -T3" # Set sane defaults for command string
$location = "nmap" # In case nmap is not in PATH
$targets = ""

foreach ( $i in $a ) {
    $s = $i.IPAddress + "/" + $i.PrefixLength
    $targets = $targets + " " + $s
}
$arguments = $arguments + " " + $targets

Start-Process $location -ArgumentList $arguments -Wait 

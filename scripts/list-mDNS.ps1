Get-NetUDPEndpoint -localPort 5353 | Select-Object LocalAddress,LocalPort,OwningProcess,@{ Name="Process"; Expression={((Get-Process -Id $_.OwningProcess).Name )} }
exit 0 # success
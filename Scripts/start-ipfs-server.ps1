<#
.SYNTAX       start-ipfs-server.ps1
.DESCRIPTION  starts a local IPFS server
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	$Result = (ipfs --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'ipfs' - make sure IPFS is installed and available" }

	"Step 1/4: initializing IPFS..."
	& ipfs init --profile server

	"Step 2/4: configuring IPFS..."
	& ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
	if ($lastExitCode -ne "0") { throw "'ipfs config Addresses.API' failed" }

	& ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8765
	if ($lastExitCode -ne "0") { throw "'ipfs config Addresses.Gateway' failed" }

#	& ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://raspi:5001", "http://127.0.0.1:5001", "https://webui.ipfs.io"]'
#	if ($lastExitCode -ne "0") { throw "'ipfs config Access-Control-Allow-Origin' failed" }

#	& ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST"]'
#	if ($lastExitCode -ne "0") { throw "'ipfs config Access-Control-Allow-Methods' failed" }

	"Step 3/4: increasing UDP receive buffer size..."
	& sudo sysctl -w net.core.rmem_max=2500000
	if ($lastExitCode -ne "0") { throw "'sysctl' failed" }

	"Step 4/4: starting IPFS daemon..."
	"NOTE: make sure your router does not block port 4001 (TCP/UDP) for IPv4/v6!"

	& ipfs daemon 
	if ($lastExitCode -ne "0") { throw "'ipfs daemon' failed" }

	"IPFS server has stopped"
	exit 1
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}

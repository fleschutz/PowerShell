<#
.SYNTAX       start-ipfs-server.ps1
.DESCRIPTION  starts a local IPFS server
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	"⚠️ Make sure your router does not block port 4001 (TCP/UDP) for IPv4/v6!"
	""

	"1️⃣ Step 1/5: searching for ipfs executable..."
	$Result = (ipfs --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'ipfs' - make sure IPFS is installed and available" }

	"Step 2/5: initializing..."
	& ipfs init --profile server

	"Step 3/5: configuring..."
	& ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
	if ($lastExitCode -ne "0") { throw "'ipfs config Addresses.API' failed" }

	& ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8765
	if ($lastExitCode -ne "0") { throw "'ipfs config Addresses.Gateway' failed" }

#	& ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://raspi:5001", "http://127.0.0.1:5001", "https://webui.ipfs.io"]'
#	if ($lastExitCode -ne "0") { throw "'ipfs config Access-Control-Allow-Origin' failed" }

#	& ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST"]'
#	if ($lastExitCode -ne "0") { throw "'ipfs config Access-Control-Allow-Methods' failed" }

	"Step 4/5: increasing UDP receive buffer size..."
	& sudo sysctl -w net.core.rmem_max=2500000
	if ($lastExitCode -ne "0") { throw "'sysctl' failed" }

	"Step 5/5: starting daemon..."

	& ipfs daemon 
	if ($lastExitCode -ne "0") { throw "'ipfs daemon' failed" }

	"IPFS server has stopped"
	exit 1
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}

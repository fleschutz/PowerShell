
try {
	"⏳ Installing OctoPrint (snap 'octoprint-pfs', channel 'edge')..."

	& sudo snap install octoprint-pfs --edge
	if ($lastExitCode -ne "0") { throw "'snap install octoprint-pfs' exited with code $lastExitCode" }

	"HINT: Access Octoprint's web login at: http://<HOSTNAME>:5000"
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}

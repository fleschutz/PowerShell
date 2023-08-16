
try {
	"⏳ Installing Octoprint (latest stable version)..."

	& sudo snap install octoprint-sdev
	if ($lastExitCode -ne "0") { throw "Can't install Octoprint, is it already installed?" }

	"NOTE: Octoprint's web interface can be reached at http://<HOSTNAME>:5000"
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}

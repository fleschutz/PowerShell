
try {
	"⏳ Installing OctoPrint (snap 'octoprint-sdev', latest stable version)..."

	& sudo snap install octoprint-sdev --beta 
	if ($lastExitCode -ne "0") { throw "Can't install OctoPrint, is it already installed?" }

	"HINT: Access Octoprint's web login at: http://<HOSTNAME>:5000"
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}

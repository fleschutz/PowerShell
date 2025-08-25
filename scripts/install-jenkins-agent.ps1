<#
.SYNOPSIS
        Installs the Jenkins Agent
.DESCRIPTION
        This PowerShell script installs and starts the Jenkins Agent.
.EXAMPLE
        PS> ./install-jenkins-agent.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([string]$installDir = "/opt/jenkins-agent", [string]$jenkinsURL = "", [string]$secretKey = "")

try {
	"`n⏳ (1/5) Asking for details..."
	if ($jenkinsURL -eq "") { $jenkinsURL = Read-Host "Enter the URL to the Jenkins controller" }
	if ($secretKey -eq "")  { $secretKey  = Read-Host "Enter the secret key" }
	
	 $stopWatch = [system.diagnostics.stopwatch]::startNew() 
	"`n⏳ (2/5) Installing Java Runtime Environment (JRE)..."
	& sudo apt install default-jre

	"`n⏳ (3/5) Creating installation folder at: $installDir ... (if non-existent)"
	& mkdir $installDir
	& cd $installDir

	"`n⏳ (4/5) Downloading Jenkins agent .JAR program from Jenkins controller..."
	& curl -sO $jenkinsURL/jnlpJars/agent.jar

	"`n⏳ (5/5) Starting Jenkins agent ..."
	& nohup java -jar agent.jar -url $jenkinsURL -secret $secretKey -name pi -webSocket -workDir $installDir &

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Jenkins Agent installed successfully in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}

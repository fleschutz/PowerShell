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

param([string]$installDir = "/opt/jenkins-agent", [string]$jenkinsURL = "http://tux:8080", [string]$secretKey = "")

try {
	"`n⏳ (1/4) Installing Java Runtime Environment (JRE)..."
	& sudo apt install default-jre

	"`n⏳ (2/4) Creating installation folder at: $installDir ... (if non-existent)"
	& mkdir $installDir
	& cd $installDir

	"`n⏳ (3/4) Loading current .JAR program from Jenkins controller..."
	& curl -sO $jenkinsURL/jnlpJars/agent.jar

	"`n⏳ (4/4) Starting Jenkins agent ..."
	& java -jar agent.jar -url $jenkinsURL -secret $secretKey -name pi -webSocket -workDir $installDir

	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}

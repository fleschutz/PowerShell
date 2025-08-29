<#
.SYNOPSIS
	← enter a brief description of the script here
.DESCRIPTION
	← enter a detailed description of the script here
.PARAMETER
	← enter the description of a parameter here (repeat the .PARAMETER for each parameter)
.EXAMPLE
	← enter a sample command that uses the script, optionally followed by sample output and a description (repeat the .EXAMPLE for each example)
.NOTES
	Author:        ← enter full name here
	License:       ← enter license here
.LINK
	← enter URL to additional information here
#>

#requires -version 5.1

function WriteLine([string]$line) {
	Write-Host $line -foregroundColor black -backgroundColor red
}

Clear-Host
WriteLine ""
WriteLine ""
WriteLine ""
WriteLine ""
WriteLine ""
WriteLine "███████▀▀▀░░░░░░░▀▀▀███████"
WriteLine "████▀░░░░░░░░░░░░░░░░░▀████"
WriteLine "███│░░░░░░░░░░░░░░░░░░░│███"
WriteLine "██▌│░░░░░░░░░░░░░░░░░░░│▐██"
WriteLine "██░└┐░░░░░░░░░░░░░░░░░┌┘░██"
WriteLine "██░░└┐░░░░░░░░░░░░░░░┌┘░░██"
WriteLine "██░░┌┘▄▄▄▄▄░░░░░▄▄▄▄▄└┐░░██"
WriteLine "██▌░│██████▌░░░▐██████│░▐██"
WriteLine "███░│▐███▀▀░░▄░░▀▀███▌│░███"
WriteLine "██▀─┘░░░░░░░▐█▌░░░░░░░└─▀██"
WriteLine "██▄░░░▄▄▄▓░░▀█▀░░▓▄▄▄░░░▄██"
WriteLine "████▄─┘██▌░░░░░░░▐██└─▄████"
WriteLine "█████░░▐█─┬┬┬┬┬┬┬─█▌░░█████"
WriteLine "████▌░░░▀┬┼┼┼┼┼┼┼┬▀░░░▐████"
WriteLine "█████▄░░░└┴┴┴┴┴┴┴┘░░░▄█████"
WriteLine "███████▄░░░░░░░░░░░▄███████"
WriteLine "██████████▄▄▄▄▄▄▄██████████"
WriteLine ""
WriteLine ""
WriteLine ""
WriteLine ""
WriteLine ""
exit 0 # success

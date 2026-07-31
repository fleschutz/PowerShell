<#
.SYNOPSIS
	Write insults to the console
.DESCRIPTION
	This PowerShell script writes insults to the console.
.PARAMETER insults
	Number of insults (3 by default)
.EXAMPLE
	./write-insults.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([int]$insults = 3)

$adjectives = $(
    'bankrupt'
    'base'
    'caterwauling'
    'corrupt'
    'cullionly'
    'detestable'
    'dishonest'
    'false'
    'filthsome'
    'filthy'
    'foolish'
    'foul'
    'gross'
    'heedless'
    'indistinguishable'
    'infected'
    'insatiate'
    'irksome'
    'lascivious'
    'lecherous'
    'loathsome'
    'lubbery'
    'old'
    'peevish'
    'rascaly'
    'rotten'
    'ruinous'
    'scurilous'
    'scurvy'
    'slanderous'
    'sodden-witted'
    'thin-faced'
    'toad-spotted'
    'unmannered'
    'vile wall-eyed'
)

$nouns = $(
    'Judas'
    'Satan'
    'ape'
    'ass'
    'barbermonger'
    'beggar'
    'block'
    'boy'
    'braggart'
    'butt'
    'carbuncle'
    'coward'
    'coxcomb'
    'cur'
    'dandy'
    'degenerate'
    'fiend'
    'fishmonger'
    'fool'
    'gull'
    'harpy'
    'jack'
    'jolthead'
    'knave'
    'liar'
    'lunatic'
    'maw'
    'milksop'
    'minion'
    'ratcatcher'
    'recreant'
    'rogue'
    'scold'
    'slave'
    'swine'
    'traitor'
    'varlet'
    'villain'
    'worm'
)

foreach($i in 1 .. $insults) {
	$adjective1 = $adjectives | Get-Random
	$adjective2 = $adjectives | Get-Random
	$noun = $nouns | Get-Random
	Write-Output "You $adjective1 $adjective2 $noun!"
}

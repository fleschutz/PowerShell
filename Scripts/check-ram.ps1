<#
.SYNOPSIS
	Checks the RAM 
.DESCRIPTION
	This PowerShell script queries and prints details of the installed RAM.
.EXAMPLE
	PS> ./check-ram
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function GetRAMType { param([int]$Type)
	switch($Type) {
	2 { return "DRAM" }
	5 { return "EDO" }
	6 { return "EDRAM" }
	7 { return "VRAM" }
	8 { return "SRAM" }
	10 { return "ROM" }
	11 { return "Flash" }
	12 { return "EEPROM" }
	13 { return "FEPROM" }
	14 { return "EPROM" }
	15 { return "CDRAM" }
	16 { return "3DRAM" }
	17 { return "SDRAM" }
	18 { return "SGRAM" }
	19 { return "RDRAM" }
	20 { return "DDR" }
	21 { return "DDR2" }
	22 { return "DDR2 FB-DIMM" }
	24 { return "DDR3" }
	26 { return "DDR4" }
	27 { return "DDR5" }
	28 { return "DDR6" }
	29 { return "DDR7" }
	default { return "RAM" }
	}
}

function Bytes2String { param([int64]$Bytes)
        if ($Bytes -lt 1000) { return "$Bytes bytes" }
        $Bytes /= 1000
        if ($Bytes -lt 1000) { return "$($Bytes)KB" }
        $Bytes /= 1000
        if ($Bytes -lt 1000) { return "$($Bytes)MB" }
        $Bytes /= 1000
        if ($Bytes -lt 1000) { return "$($Bytes)GB" }
        $Bytes /= 1000
        if ($Bytes -lt 1000) { return "$($Bytes)TB" }
        $Bytes /= 1000
        if ($Bytes -lt 1000) { return "$($Bytes)PB" }
        $Bytes /= 1000
        if ($Bytes -lt 1000) { return "$($Bytes)EB" }
}

try {
	if ($IsLinux) {
		# TODO
	} else {
		$Banks = Get-WmiObject -Class Win32_PhysicalMemory
		foreach ($Bank in $Banks) {
			$Capacity = Bytes2String($Bank.Capacity)
			$Type = GetRAMType $Bank.SMBIOSMemoryType
			$Speed = $Bank.Speed
			[float]$Voltage = $Bank.ConfiguredVoltage / 1000.0
			$Manufacturer = $Bank.Manufacturer
			$Location = "$($Bank.BankLabel)/$($Bank.DeviceLocator)"
			"✅ RAM $Capacity at $Location ($Type, $($Speed)MHz, $($Voltage)V, $Manufacturer)"
		}
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
## SYNOPSIS
Create and Set Custom Power Plan
## DESCRIPTION
Creates a custom power plan based on the active power plan, renames it, and sets it as the active power plan.
This PowerShell script:
1. Retrieves the active power plan GUID.
2. Duplicates the active power plan.
3. Renames the new power plan to a custom name.
4. Sets the newly created power plan as the active plan.
## EXAMPLE
	PS> ./create-power-plan.ps1

## LINK
https://github.com/Arash-Seifi/PowerShell
## NOTES
Author: Arash Seifi | License: CC0
```
try {
    # Step 1: Get the Active Power Plan GUID
    $activeGuid = powercfg /getactivescheme | Select-String -Pattern "GUID" | ForEach-Object { $_.ToString().Split(' ')[3] }
    Write-Output "Active Power Plan GUID: $activeGuid"

    # Step 2: Duplicate the Active Power Plan and capture the new GUID
    $newGuid = powercfg -duplicatescheme $activeGuid | ForEach-Object { $_.ToString().Split(' ')[3] }
    Write-Output "New Power Plan GUID: $newGuid"

    # Step 3: Rename the New Power Plan
    $customName = "My Custom Plan"
    powercfg -changename $newGuid $customName

    # Step 4: Set the New Power Plan as Active
    powercfg -setactive $newGuid

    # Output the new power plan GUID
    Write-Output "New power plan created with GUID: $newGuid and set as active."
} 
catch {
    "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    exit 1
}
```

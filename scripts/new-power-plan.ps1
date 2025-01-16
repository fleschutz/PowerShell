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
![](powershell_black_icon_64x64.png) PowerShell Cheat Sheet
===========================================================

Basic Commands
--------------
```
         Cmdlet : Commands built into shell written in .NET
      Functions : Commands written in PowerShell language
      Parameter : Argument to a Cmdlet/Function/Script
          Alias : Shortcut for a Cmdlet or Function
        Scripts : Text files with .ps1 extension
   Applications : Existing windows programs
      Pipelines : Pass objects Get-process word | Stop-Process
         Ctrl+c : Interrupt current command
     Left/right : Navigate editing cursor
Ctrl+left/right : Navigate a word at a time
     Home / End : End Move to start / end of line
      Up / down : Move up and down through history
         Insert : Toggles between insert/overwrite mode
             F7 : Command history in a window
Tab / Shift-Tab : Command line completion
```


Commands to get Help
--------------------
```
Get-Command                                               # Retrieves a list of all the commands available to PowerShell
                                                          # (native binaries in $env:PATH + cmdlets / functions from PowerShell modules)
Get-Command -Module Microsoft*                            # Retrieves a list of all the PowerShell commands exported from modules named Microsoft*
Get-Command -Name *item                                   # Retrieves a list of all commands (native binaries + PowerShell commands) ending in "item"

Get-Help                                                  # Get all help topics
Get-Help -Name about_Variables                            # Get help for a specific about_* topic (aka. man page)
Get-Help -Name Get-Command                                # Get help for a specific PowerShell function
Get-Help -Name Get-Command -Parameter Module              # Get help for a specific parameter on a specific command
```

Variables
---------
```
$a = 0                                                    # Initialize a variable
[int]$a = 'Paris'                                         # Initialize a variable, with the specified type (throws an exception)
[string]$a = 'Paris'                                      # Initialize a variable, with the specified type (doesn't throw an exception)
$a,$b = 0 or $a,$b = 'a','b'                              # Assign multiple variables
$a,$b = $b,$a                                             # Flip variables
$var=[int]5                                               # Strongly typed variable

Get-Command -Name *varia*                                 # Get a list of commands related to variable management

Get-Variable                                              # Get an array of objects, representing the variables in the current and parent scopes 
Get-Variable | ? { $PSItem.Options -contains 'constant' } # Get variables with the "Constant" option set
Get-Variable | ? { $PSItem.Options -contains 'readonly' } # Get variables with the "ReadOnly" option set

New-Variable -Name FirstName -Value Trevor
New-Variable FirstName -Value Trevor -Option Constant     # Create a constant variable, that can only be removed by restarting PowerShell
New-Variable FirstName -Value Trevor -Option ReadOnly     # Create a variable that can only be removed by specifying the -Force parameter on Remove-Variable

Remove-Variable -Name firstname                           # Remove a variable, with the specified name
Remove-Variable -Name firstname -Force                    # Remove a variable, with the specified name, that has the "ReadOnly" option set
```


Operators
---------
```
$a = 2                                                    # Basic variable assignment operator
$a += 1                                                   # Incremental assignment operator
$a -= 1                                                   # Decrement assignment operator
$a++                                                      # Incremental assignment operator
$a--                                                      # Decrement assignment operator

$a -eq 0                                                  # Equality comparison operator
$a -ne 5                                                  # Not-equal comparison operator
$a -gt 2                                                  # Greater than comparison operator
$a -lt 3                                                  # Less than comparison operator

$FirstName = 'Trevor'
$FirstName -like 'T*'                                     # Perform string comparison using the -like operator, which supports the wildcard (*) character. Returns $true

$BaconIsYummy = $true
$FoodToEat = $BaconIsYummy ? 'bacon' : 'beets'            # Sets the $FoodToEat variable to 'bacon' using the ternary operator

'Celery' -in @('Bacon', 'Sausage', 'Steak', 'Chicken')    # Returns boolean value indicating if left-hand operand exists in right-hand array
'Celery' -notin @('Bacon', 'Sausage', 'Steak')            # Returns $true, because Celery is not part of the right-hand list

5 -is [string]                                            # Is the number 5 a string value? No. Returns $false.
5 -is [int32]                                             # Is the number 5 a 32-bit integer? Yes. Returns $true.
5 -is [int64]                                             # Is the number 5 a 64-bit integer? No. Returns $false.
'Trevor' -is [int64]                                      # Is 'Trevor' a 64-bit integer? No. Returns $false.
'Trevor' -isnot [string]                                  # Is 'Trevor' NOT a string? No. Returns $false.
'Trevor' -is [string]                                     # Is 'Trevor' a string? Yes. Returns $true.
$true -is [bool]                                          # Is $true a boolean value? Yes. Returns $true.
$false -is [bool]                                         # Is $false a boolean value? Yes. Returns $true.
5 -is [bool]                                              # Is the number 5 a boolean value? No. Returns $false.
```


Flow Control
------------
```
if (1 -eq 1) { }                                          # Do something if 1 is equal to 1

do { 'hi' } while ($false)                                # Loop while a condition is true (always executes at least once)

while ($false) { 'hi' }                                   # While loops are not guaranteed to run at least once
while ($true) { }                                         # Do something indefinitely
while ($true) { if (1 -eq 1) { break } }                  # Break out of an infinite while loop conditionally

for ($i = 0; $i -le 10; $i++) { Write-Host $i }           # Iterate using a for..loop
foreach ($item in (Get-Process)) { }                      # Iterate over items in an array

switch ('test') { 'test' { 'matched'; break } }           # Use the switch statement to perform actions based on conditions. Returns string 'matched'
switch -regex (@('Trevor', 'Daniel', 'Bobby')) {          # Use the switch statement with regular expressions to match inputs
  'o' { $PSItem; break }                                  # NOTE: $PSItem or $_ refers to the "current" item being matched in the array
}
switch -regex (@('Trevor', 'Daniel', 'Bobby')) {          # Switch statement omitting the break statement. Inputs can be matched multiple times, in this scenario.
  'e' { $PSItem }
  'r' { $PSItem }
}
```

Functions
---------
```
function add ($a, $b) { $a + $b }                         # A basic PowerShell function

function Do-Something {                                   # A PowerShell Advanced Function, with all three blocks declared: BEGIN, PROCESS, END
  [CmdletBinding]()]
  param ()
  begin { }
  process { }
  end { }
}
```


Regular Expressions
-------------------
```
'Trevor' -match '^T\w*'                                   # Perform a regular expression match against a string value. # Returns $true and populates $matches variable
$matches[0]                                               # Returns 'Trevor', based on the above match

@('Joe', 'Billy', 'Bobby') -match '^B'                    # Perform a regular expression match against an array of string values. Returns Billy, Bobby

$regex = [regex]'(\w{3,8})'
$regex.Matches('Bobby Dillon Joe Jacob').Value            # Find multiple matches against a singleton string value.
```




Working with Modules
--------------------
```
Get-Command -Name *module* -Module mic*core                 # Which commands can I use to work with modules?

Get-Module -ListAvailable                                   # Show me all of the modules installed on my system (controlled by $env:PSModulePath)
Get-Module                                                  # Show me all of the modules imported into the current session

$PSModuleAutoLoadingPreference = 0                          # Disable auto-loading of installed PowerShell modules, when a command is invoked

Import-Module -Name NameIT                                  # Explicitly import a module, from the specified filesystem path or name (must be present in $env:PSModulePath)
Remove-Module -Name NameIT                                  # Remove a module from the scope of the current PowerShell session

New-ModuleManifest                                          # Helper function to create a new module manifest. You can create it by hand instead.

New-Module -Name trevor -ScriptBlock {                      # Create an in-memory PowerShell module (advanced users)
  function Add($a,$b) { $a + $b } }

New-Module -Name trevor -ScriptBlock {                      # Create an in-memory PowerShell module, and make it visible to Get-Module (advanced users)
  function Add($a,$b) { $a + $b } } | Import-Module
```


Module Management
-----------------
```
Get-Command -Module PowerShellGet                           # Explore commands to manage PowerShell modules

Find-Module -Tag cloud                                      # Find modules in the PowerShell Gallery with a "cloud" tag
Find-Module -Name ps*                                       # Find modules in the PowerShell Gallery whose name starts with "PS"

Install-Module -Name NameIT -Scope CurrentUser -Force       # Install a module to your personal directory (non-admin)
Install-Module -Name NameIT -Force                          # Install a module to your personal directory (admin / root)
Install-Module -Name NameIT -RequiredVersion 1.9.0          # Install a specific version of a module

Uninstall-Module -Name NameIT                               # Uninstall module called "NameIT", only if it was installed via Install-Module

Register-PSRepository -Name <repo> -SourceLocation <uri>    # Configure a private PowerShell module registry
Unregister-PSRepository -Name <repo>                        # Deregister a PowerShell Repository
```


Filesystem
----------
```
New-Item -Path c:\test -ItemType Directory                  # Create a directory
mkdir c:\test2                                              # Create a directory (short-hand)

New-Item -Path c:\test\myrecipes.txt                        # Create an empty file
Set-Content -Path c:\test.txt -Value ''                     # Create an empty file
[System.IO.File]::WriteAllText('testing.txt', '')           # Create an empty file using .NET Base Class Library

Remove-Item -Path testing.txt                               # Delete a file
[System.IO.File]::Delete('testing.txt')                     # Delete a file using .NET Base Class Library
```


Hashtables (Dictionary)
-----------------------
```
$Person = @{
  FirstName = 'Joe'
  LastName = 'Doe'
  Likes = @(
    'Bacon',
    'Beer'
  )
}                                                           # Create a PowerShell HashTable

$Person.FirstName                                           # Retrieve an item from a HashTable
$Person.Likes[-1]                                           # Returns the last item in the "Likes" array, in the $Person HashTable (software)
$Person.Age = 50                                            # Add a new property to a HashTable
```


Windows Management Instrumentation (WMI) (Windows only)
-------------------------------------------------------
```
Get-CimInstance -ClassName Win32_BIOS                       # Retrieve BIOS information
Get-CimInstance -ClassName Win32_DiskDrive                  # Retrieve information about locally connected physical disk devices
Get-CimInstance -ClassName Win32_PhysicalMemory             # Retrieve information about install physical memory (RAM)
Get-CimInstance -ClassName Win32_NetworkAdapter             # Retrieve information about installed network adapters (physical + virtual)
Get-CimInstance -ClassName Win32_VideoController            # Retrieve information about installed graphics / video card (GPU)

Get-CimClass -Namespace root\cimv2                          # Explore the various WMI classes available in the root\cimv2 namespace
Get-CimInstance -Namespace root -ClassName __NAMESPACE      # Explore the child WMI namespaces underneath the root\cimv2 namespace
```


Asynchronous Event Registration
-------------------------------
```
#### Register for filesystem events
$Watcher = [System.IO.FileSystemWatcher]::new('c:\tmp')
Register-ObjectEvent -InputObject $Watcher -EventName Created -Action {
  Write-Host -Object 'New file created!!!'
}                                                           

#### Perform a task on a timer (ie. every 5000 milliseconds)
$Timer = [System.Timers.Timer]::new(5000)
Register-ObjectEvent -InputObject $Timer -EventName Elapsed -Action {
  Write-Host -ForegroundColor Blue -Object 'Timer elapsed! Doing some work.'
}
$Timer.Start()
```


PowerShell Drives (PSDrives)
----------------------------
```
Get-PSDrive                                                 # List all the PSDrives on the system
New-PSDrive -Name videos -PSProvider Filesystem -Root x:\data\content\videos  # Create a new PSDrive that points to a filesystem location
New-PSDrive -Name h -PSProvider FileSystem -Root '\\storage\h$\data' -Persist # Create a persistent mount on a drive letter, visible in Windows Explorer
Set-Location -Path videos:                                  # Switch into PSDrive context
Remove-PSDrive -Name xyz                                    # Delete a PSDrive
```

Data Management
---------------
```
Get-Process | Group-Object -Property Name                   # Group objects by property name
Get-Process | Sort-Object -Property Id                      # Sort objects by a given property name
Get-Process | Where-Object -FilterScript { $PSItem.Name -match '^c' } # Filter objects based on a property matching a value
gps | where Name -match '^c'                                # Abbreviated form of the previous statement
```


PowerShell Classes
------------------
```
class Person {
  [string] $FirstName                                       # Define a class property as a string
  [string] $LastName = 'Doe'                                # Define a class property with a default value
  [int] $Age                                                # Define a class property as an integer
  
  Person() {                                                # Add a default constructor (no input parameters) for a class
  }
  
  Person([string] $FirstName) {                             # Define a class constructor with a single string parameter
    $this.FirstName = $FirstName
  }
  
  [string] FullName() {
    return '{0} {1}' -f $this.FirstName, $this.LastName
  }
}
$Person01 = [Person]::new()                                 # Instantiate a new Person object.
$Person01.FirstName = 'Joe'                                 # Set the FirstName property on the Person object.
$Person01.FullName()                                        # Call the FullName() method on the Person object. Returns 'Trevor Sullivan'


class Server {                                              # Define a "Server" class, to manage remote servers. Customize this based on your needs.
  [string] $Name
  [System.Net.IPAddress] $IPAddress                         # Define a class property as an IPaddress object
  [string] $SSHKey = "$HOME/.ssh/id_rsa"                    # Set the path to the private key used to authenticate to the server
  [string] $Username                                        # Set the username to login to the remote server with
  
  RunCommand([string] $Command) {                           # Define a method to call a command on the remote server, via SSH
    ssh -i $this.SSHKey $this.Username@$this.Name $this.Command
  }
}

$Server01 = [Server]::new()                                 # Instantiate the Server class as a new object
$Server01.Name = 'webserver01.local'                        # Set the "name" of the remote server
$Server01.Username = 'root'                                 # Set the username property of the "Server" object
$Server01.RunCommand("hostname")                            # Run a command on the remote server
```


REST APIs
---------
```
$Params = @{
  Uri = 'https://api.github.com/events'
  Method = 'Get'
}
Invoke-RestMethod @Params                                   # Call a REST API, using the HTTP GET method
```

Useful Links
------------
* PowerShell documentation: https://docs.microsoft.com/en-us/powershell
* Tutorial: https://www.guru99.com/powershell-tutorial.html
* Video tutorials: https://www.youtube.com/results?search_query=PowerShell
* FAQ's: https://github.com/fleschutz/PowerShell/blob/main/docs/FAQ.md
* 500+ sample scripts: https://github.com/fleschutz/PowerShell


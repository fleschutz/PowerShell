Script: *install-powershell.ps1*
========================

By default, the latest PowerShell release package will be installed.
If '-Daily' is specified, then the latest PowerShell daily package will be installed.

Parameters
----------
```powershell
PS> ./install-powershell.ps1 [-Destination <String>] [-Daily] [-DoNotOverwrite] [-AddToPath] [-Preview] [<CommonParameters>]

PS> ./install-powershell.ps1 [-UseMSI] [-Quiet] [-AddExplorerContextMenu] [-EnablePSRemoting] [-Preview] [<CommonParameters>]

-Destination <String>
    The destination path to install PowerShell to.
    
    Required?                    false
    Position?                    named
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-Daily [<SwitchParameter>]
    Install PowerShell from the daily build.
    Note that the 'PackageManagement' module is required to install a daily package.
    
    Required?                    false
    Position?                    named
    Default value                False
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-DoNotOverwrite [<SwitchParameter>]
    Do not overwrite the destination folder if it already exists.
    
    Required?                    false
    Position?                    named
    Default value                False
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-AddToPath [<SwitchParameter>]
    On Windows, add the absolute destination path to the 'User' scope environment variable 'Path';
    On Linux, make the symlink '/usr/bin/pwsh' points to "$Destination/pwsh";
    On MacOS, make the symlink '/usr/local/bin/pwsh' points to "$Destination/pwsh".
    
    Required?                    false
    Position?                    named
    Default value                False
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-UseMSI [<SwitchParameter>]
    
    Required?                    false
    Position?                    named
    Default value                False
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-Quiet [<SwitchParameter>]
    
    Required?                    false
    Position?                    named
    Default value                False
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-AddExplorerContextMenu [<SwitchParameter>]
    
    Required?                    false
    Position?                    named
    Default value                False
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-EnablePSRemoting [<SwitchParameter>]
    
    Required?                    false
    Position?                    named
    Default value                False
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-Preview [<SwitchParameter>]
    
    Required?                    false
    Position?                    named
    Default value                False
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS > Install the daily build
.\install-powershell.ps1 -Daily

```

Example
-------
```powershell
PS > Invoke this script directly from GitHub
Invoke-Expression "& { $(Invoke-RestMethod 'https://aka.ms/install-powershell.ps1') } -daily"

```

Script Content
--------------
```powershell
<#
.Synopsis
    Install PowerShell on Windows, Linux or macOS.
.DESCRIPTION
    By default, the latest PowerShell release package will be installed.
    If '-Daily' is specified, then the latest PowerShell daily package will be installed.
.Parameter Destination
    The destination path to install PowerShell to.
.Parameter Daily
    Install PowerShell from the daily build.
    Note that the 'PackageManagement' module is required to install a daily package.
.Parameter DoNotOverwrite
    Do not overwrite the destination folder if it already exists.
.Parameter AddToPath
    On Windows, add the absolute destination path to the 'User' scope environment variable 'Path';
    On Linux, make the symlink '/usr/bin/pwsh' points to "$Destination/pwsh";
    On MacOS, make the symlink '/usr/local/bin/pwsh' points to "$Destination/pwsh".
.EXAMPLE
    Install the daily build
    .\install-powershell.ps1 -Daily
.EXAMPLE
    Invoke this script directly from GitHub
    Invoke-Expression "& { $(Invoke-RestMethod 'https://aka.ms/install-powershell.ps1') } -daily"
#>

#requires -version 5.1

[CmdletBinding(DefaultParameterSetName = "Daily")]
param(
    [Parameter(ParameterSetName = "Daily")]
    [string] $Destination,

    [Parameter(ParameterSetName = "Daily")]
    [switch] $Daily,

    [Parameter(ParameterSetName = "Daily")]
    [switch] $DoNotOverwrite,

    [Parameter(ParameterSetName = "Daily")]
    [switch] $AddToPath,

    [Parameter(ParameterSetName = "MSI")]
    [switch] $UseMSI,

    [Parameter(ParameterSetName = "MSI")]
    [switch] $Quiet,

    [Parameter(ParameterSetName = "MSI")]
    [switch] $AddExplorerContextMenu,

    [Parameter(ParameterSetName = "MSI")]
    [switch] $EnablePSRemoting,

    [Parameter()]
    [switch] $Preview
)

Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

$IsLinuxEnv = (Get-Variable -Name "IsLinux" -ErrorAction Ignore) -and $IsLinux
$IsMacOSEnv = (Get-Variable -Name "IsMacOS" -ErrorAction Ignore) -and $IsMacOS
$IsWinEnv = !$IsLinuxEnv -and !$IsMacOSEnv

if (-not $Destination) {
    if ($IsWinEnv) {
        $Destination = "$env:LOCALAPPDATA\Microsoft\powershell"
    } else {
	if (Test-Path -path "/opt/PowerShell" -pathType container) {
		$Destination = "/opt/PowerShell"
	} else {
        	$Destination = "~/.powershell"
	}
    }

    if ($Daily) {
        $Destination = "${Destination}-daily"
    }
}

$Destination = $PSCmdlet.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Destination)

if (-not $UseMSI) {
    #Write-Host "Installation destination path: $Destination"
} else {
    if (-not $IsWinEnv) {
        throw "-UseMSI is only supported on Windows"
    } else {
        $MSIArguments = @()
        if($AddExplorerContextMenu) {
            $MSIArguments += "ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1"
        }
        if($EnablePSRemoting) {
            $MSIArguments += "ENABLE_PSREMOTING=1"
        }
    }
}

# Expand an archive using Expand-archive when available
# and the DotNet API when it is not
function Expand-ArchiveInternal {
    [CmdletBinding()]
    param(
        $Path,
        $DestinationPath
    )

    if((Get-Command -Name Expand-Archive -ErrorAction Ignore))
    {
        Expand-Archive -Path $Path -DestinationPath $DestinationPath
    }
    else
    {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        $resolvedPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)
        $resolvedDestinationPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($DestinationPath)
        [System.IO.Compression.ZipFile]::ExtractToDirectory($resolvedPath,$resolvedDestinationPath)
    }
}

function Remove-Destination([string]$Destination) {
    if (Test-Path -path $Destination -pathType container) {
        if ($DoNotOverwrite) {
            throw "Destination folder '$Destination' already exist. Use a different path or omit '-DoNotOverwrite' to overwrite."
        }
        if (Test-Path -path "$Destination.old") {
            Remove-Item "$Destination.old" -Recurse -Force
        }
        if ($IsWinEnv -and ($Destination -eq $PSHOME)) {
       	    Write-Host "⏳ (3/4) Removing old installation at $Destination... "
            # handle the case where the updated folder is currently in use
            Get-ChildItem -Recurse -File -Path $PSHOME | ForEach-Object {
                if ($_.extension -eq ".old") {
                    Remove-Item $_
                } else {
                    Move-Item $_.fullname "$($_.fullname).old"
                }
            }
        } else {
       	    Write-Host "⏳ (3/5) Moving old installation to $($Destination).old... " 
            # Unix systems don't keep open file handles so you can just move files/folders even if in use
            sudo mv "$Destination" "$($Destination).old"
        }
    }
}

<#
.SYNOPSIS
    Validation for Add-PathTToSettingsToSettings.
.DESCRIPTION
    Validates that the parameter being validated:
    - is not null
    - is a folder and exists
    - and that it does not exist in settings where settings is:
        = the process PATH for Linux/OSX
        - the registry PATHs for Windows
#>
function Test-PathNotInSettings($Path) {
    if ([string]::IsNullOrWhiteSpace($Path)) {
        throw 'Argument is null'
    }

    # Remove ending DirectorySeparatorChar for comparison purposes
    $Path = [System.Environment]::ExpandEnvironmentVariables($Path.TrimEnd([System.IO.Path]::DirectorySeparatorChar));

    if (-not [System.IO.Directory]::Exists($Path)) {
        throw "Path does not exist: $Path"
    }

    # [System.Environment]::GetEnvironmentVariable automatically expands all variables
    [System.Array] $InstalledPaths = @()
    if ([System.Environment]::OSVersion.Platform -eq "Win32NT") {
        $InstalledPaths += @(([System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::User)) -split ([System.IO.Path]::PathSeparator))
        $InstalledPaths += @(([System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine)) -split ([System.IO.Path]::PathSeparator))
    } else {
        $InstalledPaths += @(([System.Environment]::GetEnvironmentVariable('PATH'), [System.EnvironmentVariableTarget]::Process) -split ([System.IO.Path]::PathSeparator))
    }

    # Remove ending DirectorySeparatorChar in all items of array for comparison purposes
    $InstalledPaths = $InstalledPaths | ForEach-Object { $_.TrimEnd([System.IO.Path]::DirectorySeparatorChar) }

    # if $InstalledPaths is in setting return false
    if ($InstalledPaths -icontains $Path) {
        throw 'Already in PATH environment variable'
    }

    return $true
}

<#
.Synopsis
    Adds a Path to settings (Supports Windows Only)
.DESCRIPTION
    Adds the target path to the target registry.
.Parameter Path
    The path to add to the registry. It is validated with Test-PathNotInSettings which ensures that:
    -The path exists
    -Is a directory
    -Is not in the registry (HKCU or HKLM)
.Parameter Target
    The target hive to install the Path to.
    Must be either User or Machine
    Defaults to User
#>

function Add-PathTToSettings {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({Test-PathNotInSettings $_})]
        [string] $Path,

        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet([System.EnvironmentVariableTarget]::User, [System.EnvironmentVariableTarget]::Machine)]
        [System.EnvironmentVariableTarget] $Target = ([System.EnvironmentVariableTarget]::User)
    )

    if (-not $IsWinEnv) {
        return
    }

    if ($Target -eq [System.EnvironmentVariableTarget]::User) {
        [string] $Environment = 'Environment'
        [Microsoft.Win32.RegistryKey] $Key = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey($Environment, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree)
    } else {
        [string] $Environment = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment'
        [Microsoft.Win32.RegistryKey] $Key = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($Environment, [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree)
    }

    # $key is null here if it the user was unable to get ReadWriteSubTree access.
    if ($null -eq $Key) {
        throw (New-Object -TypeName 'System.Security.SecurityException' -ArgumentList "Unable to access the target registry")
    }

    # Get current unexpanded value
    [string] $CurrentUnexpandedValue = $Key.GetValue('PATH', '', [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames)

    # Keep current PathValueKind if possible/appropriate
    try {
        [Microsoft.Win32.RegistryValueKind] $PathValueKind = $Key.GetValueKind('PATH')
    } catch {
        [Microsoft.Win32.RegistryValueKind] $PathValueKind = [Microsoft.Win32.RegistryValueKind]::ExpandString
    }

    # Evaluate new path
    $NewPathValue = [string]::Concat($CurrentUnexpandedValue.TrimEnd([System.IO.Path]::PathSeparator), [System.IO.Path]::PathSeparator, $Path)

    # Upgrade PathValueKind to [Microsoft.Win32.RegistryValueKind]::ExpandString if appropriate
    if ($NewPathValue.Contains('%')) { $PathValueKind = [Microsoft.Win32.RegistryValueKind]::ExpandString }

    $Key.SetValue("PATH", $NewPathValue, $PathValueKind)
}

if ($IsLinux) {
    $platform = (uname -i)
    if ($platform -eq "x86_64") { $architecture = "x64" }
    elseif ($platform -eq "x86_32") { $architecture = "x86" }
    elseif ($platform -eq "aarch64") { $architecture = "arm64" }
    elseif ($platform -eq "aarch32") { $architecture = "arm32" }
    else { Write-Host "Unknown platform $platform" }
} elseif (-not $IsWinEnv) {
    $architecture = "x64"
} elseif ($(Get-ComputerInfo -Property OsArchitecture).OsArchitecture -eq "ARM 64-bit Processor") {
    $architecture = "arm64"
} else {
    switch ($env:PROCESSOR_ARCHITECTURE) {
        "AMD64" { $architecture = "x64" }
        "x86" { $architecture = "x86" }
        default { throw "PowerShell package for OS architecture '$_' is not supported." }
    }
}
$tempDir = Join-Path ([System.IO.Path]::GetTempPath()) ([System.IO.Path]::GetRandomFileName())
$null = New-Item -ItemType Directory -Path $tempDir -Force -ErrorAction SilentlyContinue
try {
    # Setting Tls to 12 to prevent the Invoke-WebRequest : The request was
    # aborted: Could not create SSL/TLS secure channel. error.
    $originalValue = [Net.ServicePointManager]::SecurityProtocol
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

    if ($Daily) {
        $metadata = Invoke-RestMethod 'https://aka.ms/pwsh-buildinfo-daily'
        $release = $metadata.ReleaseTag -replace '^v'
        $blobName = $metadata.BlobName

        # Get version from currently installed PowerShell Daily if available.
        $pwshPath = if ($IsWinEnv) {Join-Path $Destination "pwsh.exe"} else {Join-Path $Destination "pwsh"}
        $currentlyInstalledVersion = if(Test-Path $pwshPath) {
            ((& $pwshPath -version) -split " ")[1]
        }

        if($currentlyInstalledVersion -eq $release) {
            Write-Verbose "Latest PowerShell Daily already installed." -Verbose
            return
        }

        if ($IsWinEnv) {
            if ($UseMSI) {
                $packageName = "PowerShell-${release}-win-${architecture}.msi"
            } else {
                $packageName = "PowerShell-${release}-win-${architecture}.zip"
            }
        } elseif ($IsLinuxEnv) {
            $packageName = "powershell-${release}-linux-${architecture}.tar.gz"
        } elseif ($IsMacOSEnv) {
            $packageName = "powershell-${release}-osx-${architecture}.tar.gz"
        }

        if ($architecture -ne "x64") {
            throw "The OS architecture is '$architecture'. However, we currently only support daily package for x64."
        }


        $downloadURL = "https://pscoretestdata.blob.core.windows.net/${blobName}/${packageName}"
        Write-Verbose "About to download package from '$downloadURL'" -Verbose

        $packagePath = Join-Path -Path $tempDir -ChildPath $packageName
        if (!$PSVersionTable.ContainsKey('PSEdition') -or $PSVersionTable.PSEdition -eq "Desktop") {
            # On Windows PowerShell, progress can make the download significantly slower
            $oldProgressPreference = $ProgressPreference
            $ProgressPreference = "SilentlyContinue"
        }

        try {
            Invoke-WebRequest -Uri $downloadURL -OutFile $packagePath
        } finally {
            if (!$PSVersionTable.ContainsKey('PSEdition') -or $PSVersionTable.PSEdition -eq "Desktop") {
                $ProgressPreference = $oldProgressPreference
            }
        }

        $contentPath = Join-Path -Path $tempDir -ChildPath "new"

        $null = New-Item -ItemType Directory -Path $contentPath -ErrorAction SilentlyContinue
        if ($IsWinEnv) {
            if ($UseMSI -and $Quiet) {
                Write-Verbose "Performing quiet install"
                $ArgumentList=@("/i", $packagePath, "/quiet")
                if($MSIArguments) {
                    $ArgumentList+=$MSIArguments
                }
                $process = Start-Process msiexec -ArgumentList $ArgumentList -Wait -PassThru
                if ($process.exitcode -ne 0) {
                    throw "Quiet install failed, please rerun install without -Quiet switch or ensure you have administrator rights"
                }
            } elseif ($UseMSI) {
                if($MSIArguments) {
                    Start-Process $packagePath -ArgumentList $MSIArguments -Wait
                } else {
                    Start-Process $packagePath -Wait
                }
            } else {
                Expand-ArchiveInternal -Path $packagePath -DestinationPath $contentPath
            }
        } else {
            tar zxf $packagePath -C $contentPath
        }
    } else {
        Write-Host "⏳ (1/5) Querying infos from https://raw.githubusercontent.com ..."
        $metadata = Invoke-RestMethod https://raw.githubusercontent.com/PowerShell/PowerShell/master/tools/metadata.json
        if ($Preview) {
            $release = $metadata.PreviewReleaseTag -replace '^v'
        } else {
            $release = $metadata.ReleaseTag -replace '^v'
        }

        if ($IsWinEnv) {
            if ($UseMSI) {
                if ($architecture -eq "arm64") {
                    $packageName = "PowerShell-${release}-win-${architecture}.msix"
                } else {
                    $packageName = "PowerShell-${release}-win-${architecture}.msi"
                }
            } else {
                $packageName = "PowerShell-${release}-win-${architecture}.zip"
            }
        } elseif ($IsLinuxEnv) {
            $packageName = "powershell-${release}-linux-${architecture}.tar.gz"
        } elseif ($IsMacOSEnv) {
            $packageName = "powershell-${release}-osx-${architecture}.tar.gz"
        }
	Write-Host "         Latest release is $release for $architecture (package name: $packageName)"

        $downloadURL = "https://github.com/PowerShell/PowerShell/releases/download/v${release}/${packageName}"
        Write-Host "⏳ (2/5) Loading $downloadURL"

        $packagePath = Join-Path -Path $tempDir -ChildPath $packageName
        if (!$PSVersionTable.ContainsKey('PSEdition') -or $PSVersionTable.PSEdition -eq "Desktop") {
            # On Windows PowerShell, progress can make the download significantly slower
            $oldProgressPreference = $ProgressPreference
            $ProgressPreference = "SilentlyContinue"
        }

        try {
            Invoke-WebRequest -Uri $downloadURL -OutFile $packagePath
        } finally {
            if (!$PSVersionTable.ContainsKey('PSEdition') -or $PSVersionTable.PSEdition -eq "Desktop") {
                $ProgressPreference = $oldProgressPreference
            }
        }

        $contentPath = Join-Path -Path $tempDir -ChildPath "new"

        $null = New-Item -ItemType Directory -Path $contentPath -ErrorAction SilentlyContinue
        if ($IsWinEnv) {
            if ($UseMSI -and $architecture -eq "arm64") {
                Add-AppxPackage -Path $packagePath
            } elseif ($UseMSI -and $Quiet) {
                Write-Verbose "Performing quiet install"
                $ArgumentList=@("/i", $packagePath, "/quiet")
                if($MSIArguments) {
                    $ArgumentList+=$MSIArguments
                }
                $process = Start-Process msiexec -ArgumentList $ArgumentList -Wait -PassThru
                if ($process.exitcode -ne 0) {
                    throw "Quiet install failed, please rerun install without -Quiet switch or ensure you have administrator rights"
                }
            } elseif ($UseMSI) {
                if($MSIArguments) {
                    Start-Process $packagePath -ArgumentList $MSIArguments -Wait
                } else {
                    Start-Process $packagePath -Wait
                }
            } else {
                Expand-ArchiveInternal -Path $packagePath -DestinationPath $contentPath
            }
        } else {
            Write-Host "⏳ (3/5) Extracting to $contentPath..."
            & tar zxf $packagePath -C $contentPath
        }
    }

    if (-not $UseMSI) {
        Write-Host "⏳ (4/5) Removing old installation at $Destination ..."
        if ($IsLinuxEnv) { 
		& sudo rm -rf "$Destination"
	} else {
        	Remove-Destination "$Destination"
	}

        if (Test-Path $Destination) {
            Write-Host "⏳ (5/5) Copying files to $Destination... "
            # only copy files as folders will already exist at $Destination
            Get-ChildItem -Recurse -Path "$contentPath" -File | ForEach-Object {
                $DestinationFilePath = Join-Path $Destination $_.fullname.replace($contentPath, "")
                Copy-Item $_.fullname -Destination $DestinationFilePath
            }
        } elseif ($IsWinEnv) {
            Write-Host "⏳ (5/5) Moving new installation to $Destination... "
            $null = New-Item -Path (Split-Path -Path $Destination -Parent) -ItemType Directory -ErrorAction SilentlyContinue
            Move-Item -Path $contentPath -Destination $Destination
        } else {
            Write-Host "⏳ (5/5) Moving new installation to $Destination... "
            & sudo mv "$contentPath" "$Destination"
	}
    }

    ## Change the mode of 'pwsh' to 'rwxr-xr-x' to allow execution
    if (-not $IsWinEnv) { chmod 755 $Destination/pwsh }

    if ($AddToPath -and -not $UseMSI) {
        if ($IsWinEnv) {
            if ((-not ($Destination.StartsWith($ENV:USERPROFILE))) -and
                (-not ($Destination.StartsWith($ENV:APPDATA))) -and
                (-not ($Destination.StartsWith($env:LOCALAPPDATA)))) {
                $TargetRegistry = [System.EnvironmentVariableTarget]::Machine
                try {
                    Add-PathTToSettings -Path $Destination -Target $TargetRegistry
                } catch {
                    Write-Warning -Message "Unable to save the new path in the machine wide registry: $_"
                    $TargetRegistry = [System.EnvironmentVariableTarget]::User
                }
            } else {
                $TargetRegistry = [System.EnvironmentVariableTarget]::User
            }

            # If failed to install to machine wide path or path was not appropriate for machine wide path
            if ($TargetRegistry -eq [System.EnvironmentVariableTarget]::User) {
                try {
                    Add-PathTToSettings -Path $Destination -Target $TargetRegistry
                } catch {
                    Write-Warning -Message "Unable to save the new path in the registry for the current user : $_"
                }
            }
        } else {
            $targetPath = Join-Path -Path $Destination -ChildPath "pwsh"
            if ($IsLinuxEnv) { $symlink = "/usr/bin/pwsh" } elseif ($IsMacOSEnv) { $symlink = "/usr/local/bin/pwsh" }
            $needNewSymlink = $true

            if (Test-Path -path $symlink) {
                $linkItem = Get-Item -Path $symlink
                if ($linkItem.LinkType -ne "SymbolicLink") {
                    Write-Warning "'$symlink' already exists but it's not a symbolic link. Abort adding to PATH."
                    $needNewSymlink = $false
                } elseif ($linkItem.Target -contains $targetPath) {
                    ## The link already points to the target
                    Write-Verbose "'$symlink' already points to '$targetPath'" -Verbose
                    $needNewSymlink = $false
                }
            }

            if ($needNewSymlink) {
                $uid = id -u
                if ($uid -ne "0") { $SUDO = "sudo" } else { $SUDO = "" }

                Write-Verbose "Make symbolic link '$symlink' point to '$targetPath'..." -Verbose
                & $SUDO ln -fs $targetPath $symlink

                if ($LASTEXITCODE -ne 0) {
                    Write-Error "Could not add to PATH: failed to make '$symlink' point to '$targetPath'."
                }
            }
        }

        ## Add to the current process 'Path' if the process is not 'pwsh'
        $runningProcessName = (Get-Process -Id $PID).ProcessName
        if ($runningProcessName -ne 'pwsh') {
            $env:Path = $Destination + [System.IO.Path]::PathSeparator + $env:Path
        }
    }

    if (-not $UseMSI) {
        Write-Host "✅ PowerShell $release installed at $Destination" -noNewline
        if ($Destination -eq $PSHOME) {
            Write-Host " - Please restart pwsh now."
        } else {
	    Write-Host " "
	}
    }
} finally {
    # Restore original value
    [Net.ServicePointManager]::SecurityProtocol = $originalValue

    Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
	exit 0 # success
}
```

*(page generated by convert-ps2md.ps1 as of 08/25/2025 16:51:25)*

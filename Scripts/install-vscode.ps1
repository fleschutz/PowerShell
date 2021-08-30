<#PSScriptInfo

.VERSION 1.4.2

.GUID 539e5585-7a02-4dd6-b9a6-5dd288d0a5d0

.AUTHOR Microsoft

.COMPANYNAME Microsoft Corporation

.COPYRIGHT (c) Microsoft Corporation

.TAGS install vscode installer

.LICENSEURI https://github.com/PowerShell/vscode-powershell/blob/master/LICENSE.txt

.PROJECTURI https://github.com/PowerShell/vscode-powershell/blob/master/scripts/Install-VSCode.ps1

.ICONURI

.EXTERNALMODULEDEPENDENCIES

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES
    02/06/2021 - Fix an architecture check issue with non-English localizations.
    --
    01/04/2021 - Fix host for downloading VSCode.
    --
    07/10/2019 - Fix a version check when installing user-builds with Windows Powershell greater than 5.
    --
    30/08/2019 - Added functionality to install the "User Install" variant of Stable Edition.
    --
    07/11/2018 - Added support for PowerShell Core and macOS/Linux platforms.
    --
    15/08/2018 - Added functionality to install the new "User Install" variant of Insiders Edition.
    --
    21/03/2018 - Added functionality to install the VSCode context menus.
                 Also, VSCode is now always added to the search path.
    --
    20/03/2018 - Fix OS detection to prevent error
    --
    28/12/2017 - Added functionality to support 64-bit versions of VSCode
                 and support for installation of VSCode Insiders Edition.
    --
    Initial release.
#>

<#
.SYNOPSIS
    Installs Visual Studio Code, the PowerShell extension, and optionally
    a list of additional extensions.

.DESCRIPTION
    This script can be used to easily install Visual Studio Code and the
    PowerShell extension on your machine.  You may also specify additional
    extensions to be installed using the -AdditionalExtensions parameter.
    The -LaunchWhenDone parameter will cause VS Code to be launched as
    soon as installation has completed.

    Please contribute improvements to this script on GitHub!

    https://github.com/PowerShell/vscode-powershell/blob/master/scripts/Install-VSCode.ps1

.PARAMETER Architecture
    A validated string defining the bit version to download. Values can be either 64-bit or 32-bit.
    If 64-bit is chosen and the OS Architecture does not match, then the 32-bit build will be
    downloaded instead. If parameter is not used, then 64-bit is used as default.

.PARAMETER BuildEdition
    A validated string defining which build edition or "stream" to download:
    Stable or Insiders Edition (system install or user profile install).
    If the parameter is not used, then stable is downloaded as default.


.PARAMETER AdditionalExtensions
    An array of strings that are the fully-qualified names of extensions to be
    installed in addition to the PowerShell extension.  The fully qualified
    name is formatted as "<publisher name>.<extension name>" and can be found
    next to the extension's name in the details tab that appears when you
    click an extension in the Extensions panel in Visual Studio Code.

.PARAMETER LaunchWhenDone
    When present, causes Visual Studio Code to be launched as soon as installation
    has finished.

.PARAMETER EnableContextMenus
    When present, causes the installer to configure the Explorer context menus

.EXAMPLE
    Install-VSCode.ps1 -Architecture 32-bit

    Installs Visual Studio Code (32-bit) and the powershell extension.
.EXAMPLE
    Install-VSCode.ps1 -LaunchWhenDone

    Installs Visual Studio Code (64-bit) and the PowerShell extension and then launches
    the editor after installation completes.

.EXAMPLE
    Install-VSCode.ps1 -AdditionalExtensions 'eamodio.gitlens', 'vscodevim.vim'

    Installs Visual Studio Code (64-bit), the PowerShell extension, and additional
    extensions.

.EXAMPLE
    Install-VSCode.ps1 -BuildEdition Insider-User -LaunchWhenDone

    Installs Visual Studio Code Insiders Edition (64-bit) to the user profile and then launches the editor
    after installation completes.

.NOTES
    This script is licensed under the MIT License:

    Copyright (c) Microsoft Corporation.

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
#>
[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [parameter()]
    [ValidateSet('64-bit', '32-bit')]
    [string]$Architecture = '64-bit',

    [parameter()]
    [ValidateSet('Stable-System', 'Stable-User', 'Insider-System', 'Insider-User')]
    [string]$BuildEdition = "Stable-System",

    [Parameter()]
    [ValidateNotNull()]
    [string[]]$AdditionalExtensions = @(),

    [switch]$LaunchWhenDone,

    [switch]$EnableContextMenus
)

# Taken from https://code.visualstudio.com/docs/setup/linux#_installation
$script:VSCodeYumRepoEntry = @"
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
"@

$script:VSCodeZypperRepoEntry = @"
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
type=rpm-md
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
"@

function Test-IsOsArchX64 {
    if ($PSVersionTable.PSVersion.Major -lt 6) {
        return (Get-CimInstance -ClassName Win32_OperatingSystem).OSArchitecture -match '64'
    }

    return [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture -eq [System.Runtime.InteropServices.Architecture]::X64
}

function Get-AvailablePackageManager
{
    if (Get-Command 'apt' -ErrorAction SilentlyContinue) {
        return 'apt'
    }

    if (Get-Command 'dnf' -ErrorAction SilentlyContinue) {
        return 'dnf'
    }

    if (Get-Command 'yum' -ErrorAction SilentlyContinue) {
        return 'yum'
    }

    if (Get-Command 'zypper' -ErrorAction SilentlyContinue) {
        return 'zypper'
    }
}

function Get-CodePlatformInformation {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('32-bit', '64-bit')]
        [string]
        $Bitness,

        [Parameter(Mandatory=$true)]
        [ValidateSet('Stable-System', 'Stable-User', 'Insider-System', 'Insider-User')]
        [string]
        $BuildEdition
    )

    if ($IsWindows -or $PSVersionTable.PSVersion.Major -lt 6) {
        $os = 'Windows'
    }
    elseif ($IsLinux) {
        $os = 'Linux'
    }
    elseif ($IsMacOS) {
        $os = 'MacOS'
    }
    else {
        throw 'Could not identify operating system'
    }

    if ($Bitness -ne '64-bit' -and $os -ne 'Windows') {
        throw "Non-64-bit *nix systems are not supported"
    }

    if ($BuildEdition.EndsWith('User') -and $os -ne 'Windows') {
        throw 'User builds are not available for non-Windows systems'
    }

    switch ($BuildEdition) {
        'Stable-System' {
            $appName = "Visual Studio Code ($Bitness)"
            break
        }

        'Stable-User' {
            $appName = "Visual Studio Code ($($Architecture) - User)"
            break
        }

        'Insider-System' {
            $appName = "Visual Studio Code - Insiders Edition ($Bitness)"
            break
        }

        'Insider-User' {
            $appName = "Visual Studio Code - Insiders Edition ($($Architecture) - User)"
            break
        }
    }

    switch ($os) {
        'Linux' {
            $pacMan = Get-AvailablePackageManager

            switch ($pacMan) {
                'apt' {
                    $platform = 'linux-deb-x64'
                    $ext = 'deb'
                    break
                }

                { 'dnf','yum','zypper' -contains $_ } {
                    $platform = 'linux-rpm-x64'
                    $ext = 'rpm'
                    break
                }

                default {
                    $platform = 'linux-x64'
                    $ext = 'tar.gz'
                    break
                }
            }

            if ($BuildEdition.StartsWith('Insider')) {
                $exePath = '/usr/bin/code-insiders'
                break
            }

            $exePath = '/usr/bin/code'
            break
        }

        'MacOS' {
            $platform = 'darwin'
            $ext = 'zip'

            if ($BuildEdition.StartsWith('Insider')) {
                $exePath = '/usr/local/bin/code-insiders'
                break
            }

            $exePath = '/usr/local/bin/code'
            break
        }

        'Windows' {
            $ext = 'exe'
            switch ($Bitness) {
                '32-bit' {
                    $platform = 'win32'

                    if (Test-IsOsArchX64) {
                        $installBase = ${env:ProgramFiles(x86)}
                        break
                    }

                    $installBase = ${env:ProgramFiles}
                    break
                }

                '64-bit' {
                    $installBase = ${env:ProgramFiles}

                    if (Test-IsOsArchX64) {
                        $platform = 'win32-x64'
                        break
                    }

                    Write-Warning '64-bit install requested on 32-bit system. Installing 32-bit VSCode'
                    $platform = 'win32'
                    break
                }
            }

            switch ($BuildEdition) {
                'Stable-System' {
                    $exePath = "$installBase\Microsoft VS Code\bin\code.cmd"
                }

                'Stable-User' {
                    $exePath = "${env:LocalAppData}\Programs\Microsoft VS Code\bin\code.cmd"
                }

                'Insider-System' {
                    $exePath = "$installBase\Microsoft VS Code Insiders\bin\code-insiders.cmd"
                }

                'Insider-User' {
                    $exePath = "${env:LocalAppData}\Programs\Microsoft VS Code Insiders\bin\code-insiders.cmd"
                }
            }
        }
    }

    switch ($BuildEdition) {
        'Stable-System' {
            $channel = 'stable'
            break
        }

        'Stable-User' {
            $channel = 'stable'
            $platform += '-user'
            break
        }

        'Insider-System' {
            $channel = 'insider'
            break
        }

        'Insider-User' {
            $channel = 'insider'
            $platform += '-user'
            break
        }
    }

    $info = @{
        AppName = $appName
        ExePath = $exePath
        Platform = $platform
        Channel = $channel
        FileUri = "https://update.code.visualstudio.com/latest/$platform/$channel"
        Extension = $ext
    }

    if ($pacMan) {
        $info['PackageManager'] = $pacMan
    }

    return $info
}

function Save-WithBitsTransfer {
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $FileUri,

        [Parameter(Mandatory=$true)]
        [string]
        $Destination,

        [Parameter(Mandatory=$true)]
        [string]
        $AppName
    )

    Write-Host "`nDownloading latest $AppName..." -ForegroundColor Yellow

    Remove-Item -Force $Destination -ErrorAction SilentlyContinue

    $bitsDl = Start-BitsTransfer $FileUri -Destination $Destination -Asynchronous

    while (($bitsDL.JobState -eq 'Transferring') -or ($bitsDL.JobState -eq 'Connecting')) {
        Write-Progress -Activity "Downloading: $AppName" -Status "$([math]::round($bitsDl.BytesTransferred / 1mb))mb / $([math]::round($bitsDl.BytesTotal / 1mb))mb" -PercentComplete ($($bitsDl.BytesTransferred) / $($bitsDl.BytesTotal) * 100 )
    }

    switch ($bitsDl.JobState) {

        'Transferred' {
            Complete-BitsTransfer -BitsJob $bitsDl
            break
        }

        'Error' {
            throw 'Error downloading installation media.'
        }
    }
}

function Install-VSCodeFromTar {
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $TarPath,

        [Parameter()]
        [switch]
        $Insiders
    )

    $tarDir = Join-Path ([System.IO.Path]::GetTempPath()) 'VSCodeTar'
    $destDir = '/opt/VSCode-linux-x64'

    New-Item -ItemType Directory -Force -Path $tarDir
    try {
        Push-Location $tarDir
        tar xf $TarPath
        Move-Item -LiteralPath "$tarDir/VSCode-linux-x64" $destDir
    }
    finally {
        Pop-Location
    }

    if ($Insiders) {
        ln -s "$destDir/code-insiders" /usr/bin/code-insiders
        return
    }

    ln -s "$destDir/code" /usr/bin/code
}

# We need to be running as elevated on *nix
if (($IsLinux -or $IsMacOS) -and (id -u) -ne 0) {
    throw "Must be running as root to install VSCode.`nInvoke this script with (for example):`n`tsudo pwsh -f Install-VSCode.ps1 -BuildEdition Stable-System"
}

# User builds can only be installed on Windows systems
if ($BuildEdition.EndsWith('User') -and -not ($IsWindows -or $PSVersionTable.PSVersion.Major -lt 6)) {
    throw 'User builds are not available for non-Windows systems'
}

try {
    $prevProgressPreference = $ProgressPreference
    $ProgressPreference = 'SilentlyContinue'

    # Get information required for installation
    $codePlatformInfo = Get-CodePlatformInformation -Bitness $Architecture -BuildEdition $BuildEdition

    # Download the installer
    $tmpdir = [System.IO.Path]::GetTempPath()

    $ext = $codePlatformInfo.Extension
    $installerName = "vscode-install.$ext"

    $installerPath = [System.IO.Path]::Combine($tmpdir, $installerName)

    if ($PSVersionTable.PSVersion.Major -le 5) {
        Save-WithBitsTransfer -FileUri $codePlatformInfo.FileUri -Destination $installerPath -AppName $codePlatformInfo.AppName
    }
    # We don't want to use RPM packages -- see the installation step below
    elseif ($codePlatformInfo.Extension -ne 'rpm') {
        if ($PSCmdlet.ShouldProcess($codePlatformInfo.FileUri, "Invoke-WebRequest -OutFile $installerPath")) {
            Invoke-WebRequest -Uri $codePlatformInfo.FileUri -OutFile $installerPath
        }
    }

    # Install VSCode
    switch ($codePlatformInfo.Extension) {
        # On Debian-like Linux distros
        'deb' {
            if (-not $PSCmdlet.ShouldProcess($installerPath, 'apt install -y')) {
                break
            }

            # The deb file contains the information to install its own repository,
            # so we just need to install it
            apt install -y $installerPath
            break
        }

        # On distros using rpm packages, the RPM package doesn't set up the repo.
        # To install VSCode properly in way that the package manager tracks it,
        # we have to do things the hard way - install the repo and install the package
        'rpm' {
            $pacMan = $codePlatformInfo.PackageManager
            if (-not $PSCmdlet.ShouldProcess($installerPath, "$pacMan install -y")) {
                break
            }

            # Install the VSCode repo with the package manager
            rpm --import https://packages.microsoft.com/keys/microsoft.asc

            switch ($pacMan) {
                'zypper' {
                    $script:VSCodeZypperRepoEntry > /etc/zypp/repos.d/vscode.repo
                    zypper refresh -y
                }

                default {
                    $script:VSCodeYumRepoEntry > /etc/yum.repos.d/vscode.repo
                    & $pacMan check-update -y
                }
            }

            switch ($BuildEdition) {
                'Stable-System' {
                    & $pacMan install -y code
                }

                default {
                    & $pacMan install -y code-insiders
                }
            }
            break
        }

        # On Windows
        'exe' {
            $exeArgs = '/verysilent /tasks=addtopath'
            if ($EnableContextMenus) {
                $exeArgs = '/verysilent /tasks=addcontextmenufiles,addcontextmenufolders,addtopath'
            }

            if (-not $PSCmdlet.ShouldProcess("$installerPath $exeArgs", 'Start-Process -Wait')) {
                break
            }

            Start-Process -Wait $installerPath -ArgumentList $exeArgs
            break
        }

        # On Mac
        'zip' {
            if (-not $PSCmdlet.ShouldProcess($installerPath, "Expand-Archive -DestinationPath $zipDirPath -Force; Move-Item $zipDirPath/*.app /Applications/")) {
                break
            }

            $zipDirPath = [System.IO.Path]::Combine($tmpdir, 'VSCode')
            Expand-Archive -LiteralPath $installerPath -DestinationPath $zipDirPath -Force
            Move-Item "$zipDirPath/*.app" '/Applications/'
            break
        }

        # Remaining Linux distros using tar - more complicated
        'tar.gz' {
            if (-not $PSCmdlet.ShouldProcess($installerPath, 'Install-VSCodeFromTar (expand, move to /opt/, symlink)')) {
                break
            }

            Install-VSCodeFromTar -TarPath $installerPath -Insiders:($BuildEdition -ne 'Stable-System')
            break
        }

        default {
            throw "Unkown package type: $($codePlatformInfo.Extension)"
        }
    }

    $codeExePath = $codePlatformInfo.ExePath

    # Install any extensions
    $extensions = @("ms-vscode.PowerShell") + $AdditionalExtensions
    if ($PSCmdlet.ShouldProcess(($extensions -join ','), "$codeExePath --install-extension")) {
        if ($IsLinux -or $IsMacOS) {
            # On *nix we need to install extensions as the user -- VSCode refuses root
            $extsSlashes = $extensions -join '/'
            sudo -H -u $env:SUDO_USER pwsh -c "`$exts = '$extsSlashes' -split '/'; foreach (`$e in `$exts) { $codeExePath --install-extension `$e }"
        }
        else {
            foreach ($extension in $extensions) {
                Write-Host "`nInstalling extension $extension..." -ForegroundColor Yellow
                & $codeExePath --install-extension $extension
            }
        }
    }

    # Launch if requested
    if ($LaunchWhenDone) {
        $appName = $codePlatformInfo.AppName

        if (-not $PSCmdlet.ShouldProcess($appName, "Launch with $codeExePath")) {
            return
        }

        Write-Host "`nInstallation complete, starting $appName...`n`n" -ForegroundColor Green
        & $codeExePath
        return
    }

    if ($PSCmdlet.ShouldProcess('Installation complete!', 'Write-Host')) {
        Write-Host "`nInstallation complete!`n`n" -ForegroundColor Green
    }
}
finally {
    $ProgressPreference = $prevProgressPreference
}

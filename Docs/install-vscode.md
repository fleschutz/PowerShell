## install-vscode.ps1 - Installs Visual Studio Code, the PowerShell extension, and optionally
a list of additional extensions.

This script can be used to easily install Visual Studio Code and the
PowerShell extension on your machine.  You may also specify additional
extensions to be installed using the -AdditionalExtensions parameter.
The -LaunchWhenDone parameter will cause VS Code to be launched as
soon as installation has completed.

Please contribute improvements to this script on GitHub!

https://github.com/PowerShell/vscode-powershell/blob/master/scripts/Install-VSCode.ps1

## Parameters
```powershell
/home/markus/Repos/PowerShell/Scripts/install-vscode.ps1 [[-Architecture] <String>] [[-BuildEdition] <String>] [[-AdditionalExtensions] <String[]>] [-LaunchWhenDone] [-EnableContextMenus] [-WhatIf] [-Confirm] [<CommonParameters>]

-Architecture <String>
    A validated string defining the bit version to download. Values can be either 64-bit or 32-bit.
    If 64-bit is chosen and the OS Architecture does not match, then the 32-bit build will be
    downloaded instead. If parameter is not used, then 64-bit is used as default.
    
    Required?                    false
    Position?                    1
    Default value                64-bit
    Accept pipeline input?       false
    Accept wildcard characters?  false

-BuildEdition <String>
    A validated string defining which build edition or "stream" to download:
    Stable or Insiders Edition (system install or user profile install).
    If the parameter is not used, then stable is downloaded as default.
    
    Required?                    false
    Position?                    2
    Default value                Stable-System
    Accept pipeline input?       false
    Accept wildcard characters?  false

-AdditionalExtensions <String[]>
    An array of strings that are the fully-qualified names of extensions to be
    installed in addition to the PowerShell extension.  The fully qualified
    name is formatted as "<publisher name>.<extension name>" and can be found
    next to the extension's name in the details tab that appears when you
    click an extension in the Extensions panel in Visual Studio Code.
    
    Required?                    false
    Position?                    3
    Default value                @()
    Accept pipeline input?       false
    Accept wildcard characters?  false

-LaunchWhenDone [<SwitchParameter>]
    When present, causes Visual Studio Code to be launched as soon as installation
    has finished.
    
    Required?                    false
    Position?                    named
    Default value                False
    Accept pipeline input?       false
    Accept wildcard characters?  false

-EnableContextMenus [<SwitchParameter>]
    When present, causes the installer to configure the Explorer context menus
    
    Required?                    false
    Position?                    named
    Default value                False
    Accept pipeline input?       false
    Accept wildcard characters?  false

-WhatIf [<SwitchParameter>]
    
    Required?                    false
    Position?                    named
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false

-Confirm [<SwitchParameter>]
    
    Required?                    false
    Position?                    named
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

## Example
```powershell
PS > Install-VSCode.ps1 -Architecture 32-bit



Installs Visual Studio Code (32-bit) and the powershell extension.

```

## Example
```powershell
PS > Install-VSCode.ps1 -LaunchWhenDone



Installs Visual Studio Code (64-bit) and the PowerShell extension and then launches
the editor after installation completes.

```

## Example
```powershell
PS > Install-VSCode.ps1 -AdditionalExtensions 'eamodio.gitlens', 'vscodevim.vim'



Installs Visual Studio Code (64-bit), the PowerShell extension, and additional
extensions.

```

## Example
```powershell
PS > Install-VSCode.ps1 -BuildEdition Insider-User -LaunchWhenDone



Installs Visual Studio Code Insiders Edition (64-bit) to the user profile and then launches the editor
after installation completes.

```

## Notes
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

*Generated by convert-ps2md.ps1 using the comment-based help of install-vscode.ps1*

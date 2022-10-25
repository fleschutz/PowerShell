Set-StrictMode -off
 
#
# Module: PowerShell Console ScreenSaver Version 0.1
# Author: Oisin Grehan ( http://www.nivot.org )
#
# A PowerShell CMatrix-style screen saver for true-console hosts.
#
# This will not work in Micrisoft's ISE, Quest's PowerGUI or other graphical hosts.
# It should work fine in PowerShell+ from Idera which is a true console.
#
 
if ($host.ui.rawui.windowsize -eq $null) {
    write-warning "Sorry, I only work in a true console host like powershell.exe."
    throw
}
 
#
# Console Utility Functions
#
 
function New-Size {
    param([int]$width, [int]$height)
   
    new-object System.Management.Automation.Host.Size $width,$height
}
 
function New-Rectangle {
    param(
        [int]$left,
        [int]$top,
        [int]$right,
        [int]$bottom
    )
   
    $rect = new-object System.Management.Automation.Host.Rectangle
    $rect.left= $left
    $rect.top = $top
    $rect.right =$right
    $rect.bottom = $bottom
   
    $rect
}
 
function New-Coordinate {
    param([int]$x, [int]$y)
   
    new-object System.Management.Automation.Host.Coordinates $x, $y
}
 
function Get-BufferCell {
    param([int]$x, [int]$y)
   
    $rect = new-rectangle $x $y $x $y
   
    [System.Management.Automation.Host.buffercell[,]]$cells = $host.ui.RawUI.GetBufferContents($rect)    
   
    $cells[0,0]
}
 
function Set-BufferCell {
    [outputtype([System.Management.Automation.Host.buffercell])]
    param(
        [int]$x,
        [int]$y,
        [System.Management.Automation.Host.buffercell]$cell
    )
   
    $rect = new-rectangle $x $y $x $y
       
    # return previous
    get-buffercell $x $y
 
    # use "fill" overload with single cell rect    
    $host.ui.rawui.SetBufferContents($rect, $cell)
}
 
function New-BufferCell {
    param(
        [string]$Character,
        [consolecolor]$ForeGroundColor = $(get-buffercell 0 0).foregroundcolor,
        [consolecolor]$BackGroundColor = $(get-buffercell 0 0).backgroundcolor,
        [System.Management.Automation.Host.BufferCellType]$BufferCellType = "Complete"
    )
   
    $cell = new-object System.Management.Automation.Host.BufferCell
    $cell.Character = $Character
    $cell.ForegroundColor = $foregroundcolor
    $cell.BackgroundColor = $backgroundcolor
    $cell.BufferCellType = $buffercelltype
   
    $cell
}
 
function log {
    param($message)
    [diagnostics.debug]::WriteLine($message, "PS ScreenSaver")
}
 
#
# Main entry point for starting the animation
#
 
function Start-CMatrix {
    param(
        [int]$maxcolumns = 8,
        [int]$frameWait = 100
    )
 
    $script:winsize = $host.ui.rawui.WindowSize
    $script:columns = @{} # key: xpos; value; column
    $script:framenum = 0
       
    $prevbg = $host.ui.rawui.BackgroundColor
    $host.ui.rawui.BackgroundColor = "black"
    cls
   
    $done = $false        
   
    while (-not $done) {
 
        Write-FrameBuffer -maxcolumns $maxcolumns
 
        Show-FrameBuffer
       
        sleep -milli $frameWait
       
        $done = $host.ui.rawui.KeyAvailable        
    }
   
    $host.ui.rawui.BackgroundColor = $prevbg
    cls
}
 
# TODO: actually write into buffercell[,] framebuffer
function Write-FrameBuffer {
    param($maxColumns)
 
    # do we need a new column?
    if ($columns.count -lt $maxcolumns) {
       
        # incur staggering of columns with get-random
        # by only adding a new one 50% of the time
        if ((get-random -min 0 -max 10) -lt 5) {
           
            # search for a column not current animating
            do {
                $x = get-random -min 0 -max ($winsize.width - 1)
            } while ($columns.containskey($x))
           
            $columns.add($x, (new-column $x))
           
        }
    }
   
    $script:framenum++
}
 
# TODO: setbuffercontent with buffercell[,] framebuffer
function Show-FrameBuffer {
    param($frame)
   
    $completed=@()
   
    # loop through each active column and animate a single step/frame
    foreach ($entry in $columns.getenumerator()) {
       
        $column = $entry.value
   
        # if column has finished animating, add to the "remove" pile
        if (-not $column.step()) {            
            $completed += $entry.key
        }
    }
   
    # cannot remove from collection while enumerating, so do it here
    foreach ($key in $completed) {
        $columns.remove($key)
    }    
}
 
function New-Column {
    param($x)
   
    # return a new module that represents the column of letters and its state
    # we also pass in a reference to the main screensaver module to be able to
    # access our console framebuffer functions.
   
    new-module -ascustomobject -name "col_$x" -script {
        param(
            [int]$startx,
            [PSModuleInfo]$parentModule
         )
       
        $script:xpos = $startx
        $script:ylimit = $host.ui.rawui.WindowSize.Height
 
        [int]$script:head = 1
        [int]$script:fade = 0
		$randomLengthVariation = (1 + (get-random -min -30 -max 50)/100)
        [int]$script:fadelen = [math]::Abs($ylimit / 3 * $randomLengthVariation)
       
        $script:fadelen += (get-random -min 0 -max $fadelen)
       
        function Step {
           
            # reached the bottom yet?
            if ($head -lt $ylimit) {
 
                & $parentModule Set-BufferCell $xpos $head (
                    & $parentModule New-BufferCell -Character `
                        ([char](get-random -min 65 -max 122)) -Fore white) > $null
               
                & $parentModule Set-BufferCell $xpos ($head - 1) (
                    & $parentModule New-BufferCell -Character `
                        ([char](get-random -min 65 -max 122)) -Fore green) > $null
               
                $script:head++
            }

             # time to start rendering the darker green "tail?"
            if ($head -gt $fadelen) {

                & $parentModule Set-BufferCell $xpos $fade (
                    & $parentModule New-BufferCell -Character `
                        ([char](get-random -min 65 -max 122)) -Fore darkgreen) > $null

                # tail end
                $tail = $fade-1
                if ($tail -lt $ylimit) {
                    & $parentModule Set-BufferCell $xpos ($fade-1) (
                        & $parentModule New-BufferCell -Character `
                        ([char](get-random -min 65 -max 122)) -Fore black) > $null
                    }

                $script:fade++
            }


            # are we done animating?
            if ($fade -lt $ylimit) {
                return $true
            }

            # remove last row from tail end
            if (($fade - 1) -lt $ylimit) {
                & $parentModule Set-BufferCell $xpos ($fade - 1) (
                    & $parentModule New-BufferCell -Character `
                    ([char]' ') -Fore black) > $null
            }
                       
            $false            
        }
               
        Export-ModuleMember -function Step
       
    } -args $x, $executioncontext.sessionstate.module
}
 
function Start-ScreenSaver {
   
    # feel free to tweak maxcolumns and frame delay
    # currently 20 columns with 30ms wait
   
    Start-CMatrix -max 20 -frame 30
}
 
function Register-Timer {
 
    # prevent prompt from reregistering if explicit disable
    if ($_ssdisabled) {
        return
    }
   
    if (-not (Test-Path variable:global:_ssjob)) {
       
        # register our counter job
        $global:_ssjob = Register-ObjectEvent $_sstimer elapsed -action {
           
            $global:_sscount++;
            $global:_sssrcid = $event.sourceidentifier
               
            # hit timeout yet?
            if ($_sscount -eq $_sstimeout) {
               
                # disable this event (prevent choppiness)
                Unregister-Event -sourceidentifier $_sssrcid
                Remove-Variable _ssjob -scope Global
                           
                sleep -seconds 1
                     
                # start ss
                Start-ScreenSaver
            }
 
        }
    }
}
 
function Enable-ScreenSaver {
   
    if (-not $_ssdisabled) {
        write-warning "Screensaver is not disabled."
        return
    }
   
    $global:_ssdisabled = $false    
}
 
function Disable-ScreenSaver {
 
    if ((Test-Path variable:global:_ssjob)) {
 
        $global:_ssdisabled = $true
        Unregister-Event -SourceIdentifier $_sssrcid        
        Remove-Variable _ssjob -Scope global        
 
    } else {
        write-warning "Screen saver is not enabled."
    }
}
 
function Get-ScreenSaverTimeout {
    new-timespan -seconds $global:_sstimeout
}
 
function Set-ScreenSaverTimeout {
    [cmdletbinding(defaultparametersetname="int")]
    param(
        [parameter(position=0, mandatory=$true, parametersetname="int")]
        [int]$Seconds,
       
        [parameter(position=0, mandatory=$true, parametersetname="timespan")]
        [Timespan]$Timespan
    )
   
    if ($pscmdlet.parametersetname -eq "int") {
        $timespan = new-timespan -seconds $Seconds
    }
   
    if ($timespan.totalseconds -lt 1) {
        throw "Timeout must be greater than 0 seconds."
    }
   
    $global:_sstimeout = $timespan.totalseconds
}
 
#
# Eventing / Timer Hooks, clean up and Prompt injection
#

Start-ScreenSaver
# timeout
[int]$global:_sstimeout = 180 # default 3 minutes
 
# tick count
[int]$global:_sscount = 0
 
# modify current prompt function to reset ticks counter to 0 and
# to reregister timer, while saving for later on module onload
 
$self = $ExecutionContext.SessionState.Module
$function:global:prompt = $self.NewBoundScriptBlock(
    [scriptblock]::create(
        ("{0}`n`$global:_sscount = 0`nRegister-Timer" `
            -f ($global:_ssprompt = gc function:prompt))))
 
# configure our timer
$global:_sstimer = new-object system.timers.timer
$_sstimer.Interval = 1000 # tick once a second
$_sstimer.AutoReset = $true
$_sstimer.start()
 
# we start out disabled - use enable-screensaver
$global:_ssdisabled = $true
 
# arrange clean up on module remove
$ExecutionContext.SessionState.Module.OnRemove = {
   
    # restore prompt
    $function:global:prompt = [scriptblock]::Create($_ssprompt)
   
    # kill off eventing subscriber, if one exists
    if ($_sssrcid) {
        Unregister-Event -SourceIdentifier $_sssrcid
    }
   
    # clean up timer
    $_sstimer.Dispose()
   
    # clear out globals
    remove-variable _ss* -scope global
}
 
Export-ModuleMember -function Start-ScreenSaver, Get-ScreenSaverTimeout, `
    Set-ScreenSaverTimeout, Enable-ScreenSaver, Disable-ScreenSaver
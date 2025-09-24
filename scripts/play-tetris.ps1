<#
.SYNOPSIS
	Play Tetris 
.DESCRIPTION
	This PowerShell script let's you play the Tetris game.
.EXAMPLE
	PS> ./play-tetris.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

using Namespace System.Drawing
using Namespace System.Windows.Forms

enum ShapeTypes {
    Unspecified = 0        
    Line = 1    
    T = 2    
    Square = 3    
    L = 4   
    LMirrored = 5 
    S = 6   
    SMirrored = 7 
}

class TetrisShape {
    [System.Drawing.Point]$Position
    [System.Drawing.Color]$Color
    [ShapeTypes]$Type = 0
    [int[, ]]$Body
    
    [PSCustomObject] $Moveset = [PSCustomObject] @{
        Left  = $false
        Right = $false
        Up    = $false
        Down  = $false
    }

    [int[, ]] SetShape([ShapeTypes] $Type) {
        $Coordinates = [int[, ]]::new(5, 5)
        switch ([int]$Type) {
            Default {
                $Coordinates[2, 0] = 1
                $Coordinates[2, 1] = 1
                $Coordinates[2, 2] = 1
                $Coordinates[2, 3] = 1
            }
            2 {
                $Coordinates[2, 1] = 1
                $Coordinates[2, 2] = 1
                $Coordinates[2, 3] = 1
                $Coordinates[1, 2] = 1
            }
            3 {
                $Coordinates[2, 2] = 1
                $Coordinates[2, 3] = 1
                $Coordinates[3, 2] = 1
                $Coordinates[3, 3] = 1
            }
            4 {
                $Coordinates[1, 2] = 1
                $Coordinates[1, 3] = 1
                $Coordinates[2, 2] = 1
                $Coordinates[3, 2] = 1
            }
            5 {
                $Coordinates[1, 1] = 1
                $Coordinates[1, 2] = 1
                $Coordinates[2, 2] = 1
                $Coordinates[3, 2] = 1
            }
            6 {
                $Coordinates[1, 2] = 1
                $Coordinates[2, 1] = 1
                $Coordinates[2, 2] = 1
                $Coordinates[3, 1] = 1
            }
            7 {
                $Coordinates[1, 2] = 1
                $Coordinates[2, 2] = 1
                $Coordinates[2, 3] = 1
                $Coordinates[3, 3] = 1
            }
        }
        return $Coordinates
    }

    [bool] IsColliding([int[, ]] $Body, [int[, ]] $Table, [System.Drawing.Point] $Position) {
        for ($Y = 0; $Y -le $Body.GetUpperBound(1); $Y++) {
            for ($X = 0; $X -le $Body.GetUpperBound(0); $X++) {
                if ($Table[($Position.X + $X), ($Position.Y + $Y)] -and $Body[$X, $Y]) {
                    return $true
                }
            }
        }
        return $false
    }

    [void] Move([System.Drawing.Point] $PositionChange, [int[, ]] $TableCoordinates) {
        $PositionChange = [System.Drawing.Point]::new(
            ($this.Position.X + $PositionChange.X), 
            ($this.Position.X + $PositionChange.Y)
        )

        if (!$this.IsColliding($this.Body, $TableCoordinates, $PositionChange)) {
            $this.Position = $PositionChange
        }
    }

    [void] Rotate([bool] $Reverse, [int[, ]] $TableCoordinates) {
        if ($this.Type -ne [ShapeTypes]::Square) {
            [int[, ]] $RotatedBody = [int[, ]]::new(($this.Body.GetUpperBound(1) + 1), ($this.Body.GetUpperBound(1) + 1))

            for ($Y = 0; $Y -lt ($this.Body.GetUpperBound(1) + 1); ++$Y) {
                for ($X = 0; $X -lt ($this.Body.GetUpperBound(1) + 1); ++$X) {
                    if ($Reverse) {
                        $RotatedBody[$Y, $X] = $this.Body[$X, (($this.Body.GetUpperBound(1) + 1) - $Y - 1)]
                    }
                    else {
                        $RotatedBody[$Y, $X] = $this.Body[(($this.Body.GetUpperBound(1) + 1) - $X - 1), $Y]
                    }
                }   
            }
            if (!$this.IsColliding($RotatedBody, $TableCoordinates, $this.Position)) {
                $this.Body = $RotatedBody
            }
        }
    }

    [void] PrintBody() {
        [console]::WriteLine(
            ('Type: {0}, Color: {1}: Left: {2}, Right: {3} Position: {4}, {5}' -f 
            $this.Type, $this.Color.Name, 
            $this.Moveset.Left, $this.Moveset.Right, 
            $this.Position.X, $this.Position.Y
            )
        )
        
        ForEach ($Y in 0 .. $this.Body.GetUpperBound(1)) {
            [console]::WriteLine(
                (
                    (
                        0 .. $this.Body.GetUpperBound(0) | ForEach-Object { 
                            $this.Body[$_, $Y]
                        }
                    ) -join '-' -replace '0', '-'
                )
            )
        }
    }

    TetrisShape([ShapeTypes] $ShapeName) {
        $this.Color = [System.Drawing.Color]::FromArgb(255, (Get-Random (1 .. 255)), (Get-Random (1 .. 255)), (Get-Random (1 .. 255)))
        $this.Type = $ShapeName
        $this.Body = $this.SetShape([int]$ShapeName)
    }
}

class TetrisBoard {
    [bool] $Debug = $false
    [int32] $BlockSize
    [int32] $Width
    [int32] $Height
    [int[, ]] $Coordinates
    [TetrisShape] $NextShape
    [TetrisShape] $ActiveShape
    [PSCustomObject] $Background = [PSCustomObject] @{
        Burn  = $false
        Color = [System.Drawing.Color]::FromArgb(255, 135, 206, 235)
        Min   = 200
        Max   = 254
    }

    [void] Kill() {
        if ($null -ne $this.ActiveShape) {
            for ($Y = 0; $Y -le $this.ActiveShape.Body.GetUpperBound(1); $Y++) {
                for ($X = 0; $X -le $this.ActiveShape.Body.GetUpperBound(0); $X++) {
                    if ($this.ActiveShape.Body[$X, $Y]) {
                        Try {
                            $this.Coordinates[($this.ActiveShape.Position.X + ($X)), ($this.ActiveShape.Position.Y + $Y)] = 1
                        }
                        Catch { }
                    }
                }
            }
            $this.ActiveShape = $null
        }
    }

    [bool] LostGame() {
        # If the next shape collides with a deadblock - player lost
        if ($null -ne $this.NextShape) {
            return $this.NextShape.IsColliding($this.NextShape.Body, $this.Coordinates, $this.NextShape.Position)
        }
        else {
            return $false
        }
    }

    [void] UpdateBoard() {
        # Check for any lines to be removed, or if player has fucked up enough
    }

    [void] UpdateMoveset() {
        if ($null -ne $this.ActiveShape) {
            # Enable movement to each direction
            $this.ActiveShape.Moveset.Left = $true
            $this.ActiveShape.Moveset.Right = $true
            $this.ActiveShape.Moveset.Down = $true
            for ($Y = 0; $Y -le $this.ActiveShape.Body.GetUpperBound(1); $Y++) {
                for ($X = 0; $X -le $this.ActiveShape.Body.GetUpperBound(0); $X++) {
                    if ($this.ActiveShape.Body[$X, $Y]) {
                        if (
                            # If the left side of the block is blocked, or is out of bounds
                            $this.Coordinates[($this.ActiveShape.Position.X + ($X - 1)), ($this.ActiveShape.Position.Y + $Y)] -or
                            $this.RelativePoint($X, $Y, $this.ActiveShape).X -lt $this.BlockSize
                        ) {
                            $this.ActiveShape.Moveset.Left = $false
                        }
                        if (
                            # If the right side of the block is blocked, or is out of bounds
                            $this.Coordinates[($this.ActiveShape.Position.X + ($X + 1)), ($this.ActiveShape.Position.Y + $Y)] -or
                            $this.RelativePoint($X, $Y, $this.ActiveShape).X -ge (($this.Width * $this.BlockSize) - $this.BlockSize)
                        ) {
                            $this.ActiveShape.Moveset.Right = $false
                        }
                        if (
                            # If the block below is dead, or is out of bounds (Debug mode, invincible execpt oob)
                            (
                                !$this.Debug -and
                                $this.Coordinates[($this.ActiveShape.Position.X + $X), ($this.ActiveShape.Position.Y + ($Y + 1))]
                            ) -or
                            $this.RelativePoint($X, $Y, $this.ActiveShape).Y -ge (($this.Height * $this.BlockSize) - $this.BlockSize)
                        ) {
                            $this.ActiveShape.Moveset.Down = $false
                        }
                    }
                }
            }
            
        }
    }

    [void] NewShape() {
        if ($null -ne $this.NextShape) {
            if ($null -eq $this.ActiveShape) {
                $this.ActiveShape = $this.NextShape
                $this.NextShape = [TetrisShape]::new((Get-Random (1 .. 7)))
                $this.NextShape.Position = [System.Drawing.Point]::new((Get-Random (1 .. ($this.Width - ($this.NextShape.Body.GetUpperBound(0) + 1)))), 0)
            }
        }
        else {
            $this.NextShape = [TetrisShape]::new((Get-Random (1 .. 7)))
            $this.NextShape.Position = [System.Drawing.Point]::new((Get-Random (1 .. ($this.Width - ($this.NextShape.Body.GetUpperBound(0) + 1)))), 0)
        }
    }

    [System.Drawing.Point] RelativePoint([int]$X, [int]$Y, [TetrisShape] $Shape) {
        return [System.Drawing.Point]::new(
            (($Shape.Position.X * $this.BlockSize) + ($X * $this.BlockSize)),
            (($Shape.Position.Y * $this.BlockSize) + ($Y * $this.BlockSize))
        )
    }

    [void] AddLines([int] $Lines) {
        1 .. $Lines | ForEach-Object {
            #Write-Host 'Starting adding a new line'
            ForEach ($Y in 1 .. $this.Coordinates.GetUpperBound(1)) {
                #Write-Host ('Loop Y:{0}/{1}' -f $Y, $this.Coordinates.GetUpperBound(1))
                0 .. $this.Coordinates.GetUpperBound(0) | ForEach-Object { 
                    #Write-Host ('Column X:{0}/{1} Y:{2} = X:{3}/{4} Y:{5}' -f $_, $this.Coordinates.GetUpperBound(0), ($Y - 1), $_, $this.Coordinates.GetUpperBound(0), $Y)
                    $this.Coordinates[$_, ($Y - 1)] = $this.Coordinates[$_, $Y] 
                }
            }
            0 .. $this.Coordinates.GetUpperBound(0) | ForEach-Object { 
                #Write-Host ('Set: {0},{1} = 1' -f $_, $this.Coordinates.GetUpperBound(1))
                $this.Coordinates[$_, $this.Coordinates.GetUpperBound(1)] = Get-Random (0 .. 1)
            }
        }
    }

    [void] ClearLines() {
        ForEach ($Y in $this.Coordinates.GetUpperBound(1) .. 0) {
            if (!( -join (0 .. $this.Coordinates.GetUpperBound(0) | ForEach-Object { $this.Coordinates[$_, $Y] })).Contains('0')) {
                # Reset top row
                0 .. $this.Coordinates.GetUpperBound(0) | ForEach-Object { $this.Coordinates[$_, 0] = 0 }
                # Loop, from current full row -> row 1 and set currentrow to the one above
                ForEach ($TempY in $Y .. 1) { 
                    0 .. $this.Coordinates.GetUpperBound(0) | ForEach-Object { 
                        $this.Coordinates[$_, $TempY] = $this.Coordinates[$_, ($TempY - 1)] 
                    } 
                }
            }
        }
    }

    [void] PrintBoard() {
        for ($Y = 0; $Y -le $this.Coordinates.GetUpperBound(1); $Y++) {
            [console]::WriteLine(
                (
                    (
                        0 .. $this.Coordinates.GetUpperBound(0) | ForEach-Object { 
                            $this.Coordinates[$_, $Y]
                        }
                    ) -join '-' -replace '0', '-'
                )
            )
        }
    }

    [System.Drawing.Image] DrawImage() {
        $Buffer = [System.Drawing.Bitmap]::new($this.Width * $this.BlockSize, $this.Height * $this.BlockSize)
        $Graphics = [System.Drawing.Graphics]::FromImage($Buffer)
        # Fill buffer with a white background
        $Graphics.FillRectangle(
            [System.Drawing.SolidBrush]::new($this.Background.Color), 
            [System.Drawing.Rectangle]::new(0, 0, $Buffer.Width, $Buffer.Height)
        )

        if (
            ($this.Background.Burn -and $this.Background.Color.B -ge $this.Background.Max) -or
            (!$this.Background.Burn -and $this.Background.Color.B -lt $this.Background.Min)
        ) { 
            $this.Background.Burn = !$this.Background.Burn
        }
        if ($this.Background.Burn) {
            $this.Background.Color = [System.Drawing.Color]::FromArgb(255, $this.Background.Color.R, $this.Background.Color.G, ($this.Background.Color.B + 1))
        }
        else {
            $this.Background.Color = [System.Drawing.Color]::FromArgb(255, $this.Background.Color.R, $this.Background.Color.G, ($this.Background.Color.B - 1))
        }
        if ($null -ne $this.NextShape) {
            # Draw NextShape
            for ($Y = 0; $Y -le $this.NextShape.Body.GetUpperBound(1); $Y++) {
                for ($X = 0; $X -le $this.NextShape.Body.GetUpperBound(0); $X++) {
                    if ($this.NextShape.Body[$X, $Y]) {
                        # If this part of the shape body is solid, draw it on the table
                        $Graphics.FillRectangle(
                            [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, ($this.Background.Color.R - 60), ($this.Background.Color.G - 60), ($this.Background.Color.B - 60))), 
                            [System.Drawing.Rectangle]::new(
                                $this.RelativePoint($X, $Y, $this.NextShape).X, $this.RelativePoint($X, $Y, $this.NextShape).Y, 
                                $this.BlockSize, $this.BlockSize
                            )
                        )
                        $Graphics.FillRectangle(
                            [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, ($this.Background.Color.R - 30), ($this.Background.Color.G - 30), ($this.Background.Color.B - 30))), 
                            [System.Drawing.Rectangle]::new(
                                $this.RelativePoint($X, $Y, $this.NextShape).X, $this.RelativePoint($X, $Y, $this.NextShape).Y, 
                                $this.BlockSize - 2, $this.BlockSize - 2
                            )
                        )
                    }
                }
            }
        }

        if ($null -ne $this.ActiveShape) {
            # Draw ActiveShape
            for ($Y = 0; $Y -le $this.ActiveShape.Body.GetUpperBound(1); $Y++) {
                for ($X = 0; $X -le $this.ActiveShape.Body.GetUpperBound(0); $X++) {
                    if ($this.ActiveShape.Body[$X, $Y]) {
                        # If this part of the shape body is solid, draw it on the table
                        $Graphics.FillRectangle(
                            [System.Drawing.SolidBrush]::new([System.Drawing.Color]::Gray), 
                            [System.Drawing.Rectangle]::new(
                                $this.RelativePoint($X, $Y, $this.ActiveShape).X, $this.RelativePoint($X, $Y, $this.ActiveShape).Y, 
                                $this.BlockSize, $this.BlockSize
                            )
                        )
                        $Graphics.FillRectangle(
                            [System.Drawing.SolidBrush]::new($this.ActiveShape.Color), 
                            [System.Drawing.Rectangle]::new(
                                $this.RelativePoint($X, $Y, $this.ActiveShape).X, $this.RelativePoint($X, $Y, $this.ActiveShape).Y, 
                                $this.BlockSize - 2, $this.BlockSize - 2
                            )
                        )
                    }
                }
            }
        }
        
        # Draw DeadBlocks
        for ($Y = 0; $Y -le $this.Coordinates.GetUpperBound(1); $Y++) {
            for ($X = 0; $X -le $this.Coordinates.GetUpperBound(0); $X++) {
                if ($this.Coordinates[$X, $Y]) {
                    # Draw a Gray outline
                    $Graphics.FillRectangle(
                        [System.Drawing.SolidBrush]::new([System.Drawing.Color]::Gray), 
                        [System.Drawing.Rectangle]::new(
                            $X * $this.BlockSize, $Y * $this.BlockSize, 
                            $this.BlockSize, $this.BlockSize
                        )
                    )
                    # Fill rest of the rectangle to give 3d block effect
                    $Graphics.FillRectangle(
                        [System.Drawing.SolidBrush]::new([System.Drawing.Color]::Silver), 
                        [System.Drawing.Rectangle]::new(
                            $X * $this.BlockSize, $Y * $this.BlockSize, 
                            $this.BlockSize - 2, $this.BlockSize - 2
                        )
                    )
                }
            }
        }

        if ($this.Debug) {
            for ($Y = 0; $Y -le $this.Coordinates.GetUpperBound(1); $Y++) {
                for ($X = 0; $X -le $this.Coordinates.GetUpperBound(0); $X++) {
                    if ($this.Coordinates[$X, $Y]) {
                    }
                }
            }
            for ($Y = 0; $Y -le $this.ActiveShape.Body.GetUpperBound(1); $Y++) {
                for ($X = 0; $X -le $this.ActiveShape.Body.GetUpperBound(0); $X++) {
                    if (
                        $this.Coordinates[($this.ActiveShape.Position.X + $X), ($this.ActiveShape.Position.Y + $Y)] -and 
                        $this.ActiveShape.Body[$X, $Y]
                    ) {
                        $Graphics.DrawString( 
                            ('{0},{1}: {2}' -f 
                                ($this.ActiveShape.Position.X + $X), 
                                ($this.ActiveShape.Position.Y + $Y),
                            $this.Coordinates[($this.ActiveShape.Position.X + $X), ($this.ActiveShape.Position.Y + $Y)]
                            ),
                            [System.Drawing.Font]::new('Segoe UI', 8, [System.Drawing.FontStyle]::Regular),
                            [System.Drawing.SolidBrush]::new([System.Drawing.Color]::Red),
                            $this.RelativePoint($X, $Y, $this.ActiveShape).X, $this.RelativePoint($X, $Y, $this.ActiveShape).Y
                        )
                    }
                }
            }
            # Draws the ActiveShape Body (5x5 dimensions)
            $Graphics.DrawRectangle(
                [System.Drawing.Pen]::new($this.ActiveShape.Color, 1), 
                [System.Drawing.Rectangle]::new(
                    ($this.ActiveShape.Position.X * $this.BlockSize), ($this.ActiveShape.Position.Y * $this.BlockSize), 
                    (($this.ActiveShape.Body.GetUpperBound(0) + 1) * $this.BlockSize) , (($this.ActiveShape.Body.GetUpperBound(1) + 1) * $this.BlockSize)
                )
            )
            # Draws coordinate of the middle body
            $Graphics.DrawString( ('Type: {0}' -f $this.ActiveShape.Type ), 
                [System.Drawing.Font]::new('Segoe UI', 8, [System.Drawing.FontStyle]::Regular),
                [System.Drawing.SolidBrush]::new([System.Drawing.Color]::Red),
                1, 0 * $this.BlockSize
            )
            $Graphics.DrawString( ('Color: {0}' -f $this.ActiveShape.Color.Name ), 
                [System.Drawing.Font]::new('Segoe UI', 8, [System.Drawing.FontStyle]::Regular),
                [System.Drawing.SolidBrush]::new([System.Drawing.Color]::Red),
                1, 1 * $this.BlockSize
            )
            $Graphics.DrawString( ('Left: {0}, Right: {1}, Down: {2}' -f $this.ActiveShape.Moveset.Left, $this.ActiveShape.Moveset.Right, $this.ActiveShape.Moveset.Down ), 
                [System.Drawing.Font]::new('Segoe UI', 8, [System.Drawing.FontStyle]::Regular),
                [System.Drawing.SolidBrush]::new([System.Drawing.Color]::Red),
                1, 2 * $this.BlockSize
            )
        }
        $Graphics.Dispose()
        return $Buffer
    }

    TetrisBoard($Width, $Height, $BlockSize) {
        $this.Coordinates = [int[, ]]::new($Width, $Height)
        $this.BlockSize = $BlockSize
        $this.Width = $Width
        $this.Height = $Height
        # Generate random rubble at start
        $this.AddLines(4)
    }
}

$engine = [Hashtable]::Synchronized(@{})
$engine.Settings = @{
    Block          = @{
        Size = 30
    }
    Board          = @{
        Width  = 11
        Height = 21
    }
    SpeedMs        = 300
    CurrentSpeedMs = 300
    LoopTime       = 100
}
$engine.TetrisBoard = [TetrisBoard]::new($engine.Settings.Board.Width, $engine.Settings.Board.Height, $engine.Settings.Block.Size)
$engine.NextFall = [Datetime]::Now.AddMilliseconds($engine.Settings.CurrentSpeedMs)

$PowerShell = [PowerShell]::Create()
$PowerShell.Runspace = [RunSpaceFactory]::CreateRunspace()
$PowerShell.Runspace.Open()
$PowerShell.Runspace.SessionStateProxy.setVariable('Engine', $engine)
$IAsyncResult = $PowerShell.AddScript( {
        [void] [System.Reflection.Assembly]::LoadWithPartialName('System.Drawing')
        [void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
        [System.Windows.Forms.Application]::EnableVisualStyles()
        $engine.Form = [System.Windows.Forms.Form] @{
            Text            = 'PowerShell Tetris'
            ClientSize      = [System.Drawing.Size]::new(
                ($engine.Settings.Block.Size * $engine.Settings.Board.Width), 
                ($engine.Settings.Block.Size * $engine.Settings.Board.Height)
            )
            Font            = [System.Drawing.Font]::new('Segoe UI', 8.25, [System.Drawing.FontStyle]::Regular)
            FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Fixed3D
            KeyPreview      = $true
            MaximizeBox     = $false
        }
        $engine.PictureBox = [System.Windows.Forms.PictureBox] @{
            Dock     = [System.Windows.Forms.DockStyle]::Fill
            SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage
        }
        $engine.PictureBox.Add_MouseClick(
            {
                Param(
                    $Object,
                    [System.Windows.Forms.MouseEventArgs] $MouseEventArgs
                )
                $engine.InstantiateBlock = [System.Drawing.Point]::new(
                    ($MouseEventArgs.X - ($MouseEventArgs.X % $engine.Settings.Block.Size)) / $engine.Settings.Block.Size,
                    ($MouseEventArgs.Y - ($MouseEventArgs.Y % $engine.Settings.Block.Size)) / $engine.Settings.Block.Size
                )
            }
        )
        $engine.Form.Add_KeyUp( {
                Param( 
                    $Object,
                    [System.Windows.Forms.KeyEventArgs] $Key 
                )
                if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::Space) {
                    $engine.Settings.CurrentSpeedMs = $engine.Settings.SpeedMs
                }
                if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::Enter) {
                    $engine.SwitchShape = $true
                }
                if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::X -and $engine.TetrisBoard.Debug) {
                    $engine.AddLines = Get-Random (1 .. 4)
                }
            }
        )
        $engine.Form.Add_KeyDown( {
                Param( 
                    $Object,
                    [System.Windows.Forms.KeyEventArgs] $Key 
                )
                if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::Space) {
                    $engine.Settings.CurrentSpeedMs = $engine.Settings.SpeedMs / 4
                }
                if ($engine.TetrisBoard.Debug) {
                    if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::K) {
                        $engine.TetrisBoard.Kill()
                    }
                    if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::NumPad8) {
                        $engine.TetrisBoard.ActiveShape.Position = [System.Drawing.Point]::new(
                            $engine.TetrisBoard.ActiveShape.Position.X,
                            $engine.TetrisBoard.ActiveShape.Position.Y - 1
                        )
                    }
                    if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::NumPad4) {
                        $engine.TetrisBoard.ActiveShape.Position = [System.Drawing.Point]::new(
                            $engine.TetrisBoard.ActiveShape.Position.X - 1,
                            $engine.TetrisBoard.ActiveShape.Position.Y
                        )
                    }
                    if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::NumPad6) {
                        $engine.TetrisBoard.ActiveShape.Position = [System.Drawing.Point]::new(
                            $engine.TetrisBoard.ActiveShape.Position.X + 1,
                            $engine.TetrisBoard.ActiveShape.Position.Y
                        )
                    }
                    if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::NumPad2) {
                        $engine.TetrisBoard.ActiveShape.Position = [System.Drawing.Point]::new(
                            $engine.TetrisBoard.ActiveShape.Position.X,
                            $engine.TetrisBoard.ActiveShape.Position.Y + 1
                        )
                    }
                    if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::NumPad7) {
                        $engine.TetrisBoard.ActiveShape.Rotate($false)
                    }
                    if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::NumPad9) {
                        $engine.TetrisBoard.ActiveShape.Rotate($true)
                    }
                }
                if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::P) {
                    $engine.Debug = $true
                }
                if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::Left) {
                    $engine.XMove = [System.Drawing.Point]::new(-1, 0)
                }
                if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::Right) {
                    $engine.XMove = [System.Drawing.Point]::new(1, 0)
                }
                if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::Up) {
                    $engine.Rotate = $true
                }
                if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::Down) {
                    $engine.Rotate = $false
                }
                if ($Key.KeyCode -eq [System.Windows.Forms.Keys]::R) {
                    $engine.Renew = $true
                }
            }
        )
        $engine.Form.Controls.Add($engine.PictureBox)
        $engine.Form.Add_Resize( { if ($engine.Dispose) { $engine.Form.Close() } } )
        $engine.Form.Add_Load( { $engine.Form.Activate() })
        $engine.Form.ShowDialog()
        $engine.Form.Dispose()
    }
).BeginInvoke()

while (-not $IAsyncResult.IsCompleted) {
    if ($null -ne $engine.PictureBox) {
        $time = Measure-Command {
            if ($null -ne $engine.AddLines -and $engine.TetrisBoard.Debug) {
                Write-Host ('Adding {0} lines' -f $engine.AddLines)
                $engine.TetrisBoard.AddLines($engine.AddLines)
                $engine.AddLines = $null
            }
            if ($null -ne $engine.SwitchShape -and $null -ne $engine.TetrisBoard.ActiveShape -and $null -ne $engine.TetrisBoard.NextShape) {
                $TempShape = $engine.TetrisBoard.ActiveShape
                $engine.TetrisBoard.ActiveShape = $engine.TetrisBoard.NextShape
                $engine.TetrisBoard.NextShape = $TempShape
                $TempShape = $null
                $engine.SwitchShape = $null
            }
            if ($null -ne $engine.InstantiateBlock -and $engine.TetrisBoard.Debug) {
                $engine.TetrisBoard.Coordinates[$engine.InstantiateBlock.X, $engine.InstantiateBlock.Y] = !$engine.TetrisBoard.Coordinates[$engine.InstantiateBlock.X, $engine.InstantiateBlock.Y]
                $engine.InstantiateBlock = $null
            }
            if ($null -ne $engine.XMove) {
                $engine.TetrisBoard.UpdateMoveset()
                if (
                    ($engine.XMove.X -gt 0 -and $engine.TetrisBoard.ActiveShape.Moveset.Right) -or
                    ($engine.XMove.X -lt 0 -and $engine.TetrisBoard.ActiveShape.Moveset.Left)
                ) {
                    $engine.TetrisBoard.ActiveShape.Position = [System.Drawing.Point]::new(
                        ($engine.TetrisBoard.ActiveShape.Position.X + $engine.XMove.X), 
                        $engine.TetrisBoard.ActiveShape.Position.Y + $engine.XMove.Y
                    )
                }
                $engine.XMove = $null
            }
            if ($null -ne $engine.Debug) {
                $engine.TetrisBoard.Debug = !$engine.TetrisBoard.Debug
                $engine.Debug = $null
            }
            if ($null -ne $engine.Renew) {
                $engine.TetrisBoard.ActiveShape = $null
                $engine.Renew = $null
            }
            if ($null -ne $engine.Rotate -and $null -ne $engine.TetrisBoard.ActiveShape) {
                $engine.TetrisBoard.UpdateMoveset()
                $engine.TetrisBoard.ActiveShape.Rotate($engine.Rotate, $engine.TetrisBoard.Coordinates)
                $engine.Rotate = $null
            }
    
            if ([Datetime]::Now -ge $engine.NextFall -and $null -ne $engine.TetrisBoard.ActiveShape) {
                $engine.TetrisBoard.UpdateMoveset()
                if ($engine.TetrisBoard.ActiveShape.Moveset.Down) {
                    $engine.TetrisBoard.ActiveShape.Position = [System.Drawing.Point]::new(
                        ($engine.TetrisBoard.ActiveShape.Position.X), 
                        $engine.TetrisBoard.ActiveShape.Position.Y + 1
                    )
                }
                else {
                    $engine.TetrisBoard.Kill()
                }
                $engine.NextFall = [Datetime]::Now.AddMilliseconds($engine.Settings.CurrentSpeedMs)
            }
            if ($engine.TetrisBoard.LostGame()) {
                $engine.TetrisBoard = [TetrisBoard]::new($engine.Settings.Board.Width, $engine.Settings.Board.Height, $engine.Settings.Block.Size)
            }
            if ($null -eq $engine.TetrisBoard.ActiveShape) {
                $engine.TetrisBoard.NewShape()
            }
            $engine.TetrisBoard.UpdateMoveset()
            $engine.TetrisBoard.ClearLines()
            $engine.PictureBox.Image = $engine.TetrisBoard.DrawImage()
        }
        if ($time.TotalMilliseconds -lt $engine.Settings.LoopTime) {
            [System.Threading.Thread]::Sleep(($engine.Settings.LoopTime - $time.TotalMilliseconds))
        }
    }
}

## .SYNOPSIS
#########################
## This script copies a file, ignoring device I/O errors that abort the reading of files in most applications.
##
## .DESCRIPTION
#########################
## This script will copy the specified file even if it contains unreadable blocks caused by device I/O errors and such. The block that it can not read will be replaced with zeros. The size of the block is determined by the buffer. So, to optimize it for speed, use a large buffer. To optimize for accuracy, use a small buffer, smallest being the cluter size of the partition where your sourcefile resides.
##
## .OUTPUTS
#########################
## Errorcode 0: Copy operation finished without errors.
## Errorcode 1: Copy operation finished with unreadable blocks.
## Errorcode 2: Destination file exists, but -Overwrite not specified.
## Errorcode 3: Destination file exists but has no bad blocks (i.e. no badblocks.xml file found).
## Errorcode 4: Destination file can not be written to.
## 
## .INPUTS
#########################
## ...
##
## .PARAMETER SourceFilePath
## Path to the source file.
##  
## .PARAMETER DestinationFilePath
## Path to the destination file.
## 
## .PARAMETER Buffer
## It makes absolutely no sense to set this less than the cluser size of the partition. Setting it lower than cluster size might force rereading a bad sector in a cluster multiple times. Better is to adjust the retry option. Also, System.IO.FileStream buffers input and output for better performance. (https://docs.microsoft.com/en-us/dotnet/api/system.io.filestream).
##
## .EXAMPLE
## .\Force-Copy.ps1 -SourceFilePath "file_path_on_bad_disk" -DestinationFilePath "destinaton_path" -MaxRetries 6
## 
## This will copy file_path_on_bad_disk to destinaton_path with maximum of 6 retries on each cluster of 4096 bytes encountered. Usually 6 retries is enough to succeed, unless the sector is really completely unreadable. 
##
## .EXAMPLE
## Get-ChildItem '*.jpg' -Recurse -File -Force | foreach {.\Force-Copy.ps1 -SourceFilePath $_.FullName -DestinationFilePath ("C:\Saved"+(Split-Path $_.FullName -NoQualifier)) -Maxretries 2}
##
## Get-ChildItem '*.jpg' -Recurse -File -Force | foreach {.\Force-Copy.ps1 -SourceFilePath $_.FullName -DestinationFilePath ("C:\Saved"+(Split-Path $_.FullName -NoQualifier)) -Maxretries 2 -Overwrite}
##
## This command will copy all jpg's beginning with "Total" and copy them to "C:\Saved\relative_path" preserving their relative path.
## When run the second time, the script will only try to reread the bad blocks in the source file, skipping data which was copied well in the previous run. This can be used to efficiently retry reading bad blocks.
## 
## .EXAMPLE
## .\Force-Copy.ps1 -SourceFilePath "file_path_on_bad_disk" -DestinationFilePath "destinaton_path" -MaxRetries 6 -Position 1867264 -PositionEnd (1867264+4096)
## 
## Suppose you have a repairable rar file, which you tried to repair, and it reports that the sector 3647 at offsets 1867264..1871360 can not be repaired. You can still try to read that specific sector with the above command.
##
## .EXAMPLE
## .\Force-Copy.ps1 -SourceFilePath "file_path_on_bad_disk" -DestinationFilePath "destinaton_path" -MaxRetries 6 -BufferSize 33554432 -BufferGranularSize 4096
## 
## This will quickly copy the file using a 32 MB buffer, and if it encounters an error, it will retry using a 4K buffer (so you get the best of both worlds, performance of a large buffer, and the minimized data loss of a smaller buffer).
#########################

[CmdletBinding()]
param( 
   [Parameter(Mandatory=$true,
			  ValueFromPipeline=$true,
			  HelpMessage="Source file path.")]
   [string][ValidateScript({Test-Path -LiteralPath $_ -Type Leaf})]$SourceFilePath,
   [Parameter(Mandatory=$true,
			  ValueFromPipeline=$true,
			  HelpMessage="Destination file path.")]
   [string][ValidateScript({Test-Path -LiteralPath $_ -IsValid})]$DestinationFilePath,
   [Parameter(Mandatory=$false,
			  ValueFromPipeline=$false,
			  HelpMessage="Buffer size in bytes.")]
   [int32]$BufferSize=512*2*2*2, # 4096: the default windows cluster size.
   [Parameter(Mandatory=$false,
			  ValueFromPipeline=$false,
			  HelpMessage="Amount of tries.")]
   [int16]$MaxRetries=0,
   [Parameter(Mandatory=$false,
			  ValueFromPipeline=$false,
			  HelpMessage="Overwrite destination file?")]
   [switch]$Overwrite=$false,
   [Parameter(Mandatory=$false,
			  ValueFromPipeline=$true,
			  HelpMessage="Specify position from which to read block.")]
   [int64]$Position=0, # must be 0, current limitation
   [Parameter(Mandatory=$false,
			  ValueFromPipeline=$true,
			  HelpMessage="Specify end position for reading.")]
   [int64]$PositionEnd=-1, # must be -1, current limitation
   [Parameter(Mandatory=$false,
			  ValueFromPipeline=$false,
			  HelpMessage="Ignore the existing badblocks.xml file?")]
   [switch]$IgnoreBadBlocksFile=$false,   # not implemented
   [Parameter(Mandatory=$false,
			  ValueFromPipeline=$false,
			  HelpMessage="Will the source file be deleted in case no bad blocks are encountered?")]
   [switch]$DeleteSourceOnSuccess=$false,
   [Parameter(Mandatory=$false,
			  ValueFromPipeline=$false,
			  HelpMessage="Failback granular buffer size. Set BufferSize to a large value for speed, but revert to using a BufferGranularSize buffer when there is a read error.")]
   [int32]$BufferGranularSize=-1, # If > 0, use a larger buffer for speed, and only revert to granular size on an error block. Should be and exact divisor of buffer (BufferSize should be a multiple of BufferGranularSize)
   [Parameter(Mandatory=$false,
			  ValueFromPipeline=$true,
			  HelpMessage="Write-Progress Bar Parent Id.")]
   [int32]$ProgressParentId=-1
)

Set-StrictMode -Version 2;

# Simple assert function from http://poshcode.org/1942
function Assert {
# Example
# set-content C:\test2\Documents\test2 "hi"
# C:\PS>assert { get-item C:\test2\Documents\test2 } "File wasn't created by Set-Content!"
#
[CmdletBinding()]
param( 
   [Parameter(Position=0,ParameterSetName="Script",Mandatory=$true)]
   [ScriptBlock]$condition
,
   [Parameter(Position=0,ParameterSetName="Bool",Mandatory=$true)]
   [bool]$success
,
   [Parameter(Position=1,Mandatory=$true)]
   [string]$message
)

   $message = "ASSERT FAILED: $message"
  
   if($PSCmdlet.ParameterSetName -eq "Script") {
      try {
         $ErrorActionPreference = "STOP"
         $success = &$condition
      } catch {
         $success = $false
         $message = "$message`nEXCEPTION THROWN: $($_.Exception.GetType().FullName)"         
      }
   }
   if(!$success) {
      throw $message
   }
}

# Forces read on Stream and returns total number of bytes read into buffer.
function Force-Read() {
param( 
	[Parameter(Mandatory=$true)]
	[System.IO.FileStream]$Stream,
	[Parameter(Mandatory=$true)]
	[int64]$Position,
	[Parameter(Mandatory=$true)]
	[ref]$Buffer,
	[Parameter(Mandatory=$true)]
	[ref]$Successful,
	[Parameter(Mandatory=$false)]
	[int16]$MaxRetries=0
)

	$Stream.Position = $Position;
	$FailCounter = 0;
	$Successful.Value = $false;

	while (-not $Successful.Value) {
	
		try {
			
			$ReadLength = $Stream.Read($Buffer.Value, 0, $Buffer.Value.Length);
			# If the read operation is successful, the current position of the stream is advanced by the number of bytes read. If an exception occurs, the current position of the stream is unchanged. (http://msdn.microsoft.com/en-us/library/system.io.filestream.read.aspx)
			
		} catch [System.IO.IOException] {
			
			$ShouldHaveReadSize = [math]::Min([int64] $Buffer.Value.Length, ($Stream.Length - $Stream.Position));
			
			if (++$FailCounter -le $MaxRetries) { # Retry to read block 
			
				Write-Host $FailCounter"th retry to read "$ShouldHaveReadSize" bytes starting at "$($Stream.Position)" bytes." -ForegroundColor "DarkYellow";
				Write-Debug "Debugging read retry...";
				
				continue;
			
			} else { # Failed read of block.

				Write-Host "Can not read"$ShouldHaveReadSize" bytes starting at "$($Stream.Position)" bytes: "$($_.Exception.message) -ForegroundColor "DarkRed";
				Write-Debug "Debugging read failure...";
				
				# Should be here ONLY on UNsuccessful read!
				# $Successful is $false by default;
				$Buffer.Value = New-Object System.Byte[] ($Buffer.Value.Length);
				return $ShouldHaveReadSize;
			
			}
			
		} catch {
		
			Write-Warning "Unhandled error at $($Stream.position) bit: $($_.Exception.message)";
			Write-Debug "Unhandled error. You should debug."; 
			
			throw $_;
		
		}
		
		if ($FailCounter -gt 0) { # There were prior read failures
			Write-Host "Successfully read"$ReadLength" bytes starting at "$($SourceStream.Position - $ReadLength)" bytes." -ForegroundColor "DarkGreen";
		}
		
		# Should be here ONLY on successful read!
		$Successful.Value = $true;
		# Buffer is allready set during successful read.
		return $ReadLength;

	}

	throw "Should not be here...";
}

# Returns a custom object for storing bad block data.
function New-Block() { 
	param ([int64] $OffSet, [int32] $Size)
	  
	$block = new-object PSObject

	Add-Member -InputObject $block -MemberType NoteProperty -Name "OffSet" -Value $OffSet;
	Add-Member -InputObject $block -MemberType NoteProperty -Name "Size" -Value $Size;
	  
	return $block;
}

function Force-Copy-ProgressReport (){
param (
	[Parameter(Mandatory=$true)]
	[int64]$Position,
	[Parameter(Mandatory=$true)]
	[int64]$PositionEnd,
    [Parameter(Mandatory=$true)]
    [string] $LatestThroughput,
    [Parameter(Mandatory=$true)]
    [string] $DetailedStatus
)

    # Report total percent done
    [float] $CurrProgress = $Position/$PositionEnd * 100;
    [string] $fName = (Split-Path $SourceFilePath -Leaf)
    [string] $fPath = (Split-Path $SourceFilePath -Parent)
	Write-Progress -Activity "Force-Copy" -Status "Copying $fName ($LatestThroughput MB/s) from $fPath" -percentComplete ($CurrProgress) -CurrentOperation $DetailedStatus -ParentId $ProgressParentId;

    # Report block being read (only every so often, to avoid flicker and wasted processing)
	# Write-Progress -Id 1 -Activity "Force-Copy" -Status $DetailedStatus -percentComplete (-1);
}

# Snity checks
if ((Test-Path -LiteralPath $DestinationFilePath) -and -not $Overwrite) {
	Write-Host "Destination file $DestinationFilePath allready exists and -Overwrite not specified. Exiting." -ForegroundColor "Red";
	exit 2;
}
Assert {$Position -eq 0 -and $PositionEnd -eq -1} "Current limitation: Position and PositionEnd should be 0 and -1 respectively.";

if ($BufferGranularSize -gt 0) {
    Assert {(($BufferSize % $BufferGranularSize) -eq 0) -and ($BufferSize -gt $BufferGranularSize)} "BufferSize must be larger and divisible by BufferGranularSize.";
}

# Setting global variables
$DestinationFileBadBlocksPath = $DestinationFilePath + '.badblocks.xml';
$DestinationFileBadBlocks = @();

# Fetching SOURCE file
$SourceFile = Get-Item -LiteralPath $SourceFilePath;
Assert {$Position -lt $SourceFile.length} "Specified position out of source file bounds.";

# Fetching DESTINATION file.
if (-not (Test-Path -LiteralPath ($DestinationParentFilePath = Split-Path -Path $DestinationFilePath -Parent) -PathType Container)) { # Make destination parent folder in case it doesn't exist.
	New-Item -ItemType Directory -Path $DestinationParentFilePath | Out-Null;
}
$DestinationFile = New-Object System.IO.FileInfo ($DestinationFilePath); # Does not (!) physicaly make a file.
$NewDestinationFile = -not $DestinationFile.Exists;

# Special handling for DESTINATION file in case OVERWRITE is used! Only bad block are read from source!
if ($Overwrite -and (Test-Path -LiteralPath $DestinationFilePath)) {
	
	# Make sure the Source and Destination files have the same length prior to overwrite!
	Assert {$SourceFile.Length -eq $DestinationFile.Length} "Source and destination file have not the same size!"  
	
	# Search for badblocks.xml - if it doesn't exist then the file is probably OK, so don't do anything!
	if (-not (Test-Path -LiteralPath $DestinationFileBadBlocksPath)) {
	
		Write-Host "Destination file $DestinationFilePath has no bad blocks. It is unwise to continue... Exiting." -ForegroundColor "Red";
		exit 3;

	} else { # There is a $DestinationFileBadBlocksPath
		
		$DestinationFileBadBlocks = Import-Clixml $DestinationFileBadBlocksPath;
		Write-Host "Badblocks.xml successfully imported. Destination file has $(($DestinationFileBadBlocks | Measure-Object -Sum -Property Size).Sum) bad bytes." -ForegroundColor "Yellow";
		
		# Make sure destination file has bad blocks.
		if ($DestinationFileBadBlocksPath.Length -eq 0) {
			Write-Host "Destination file $DestinationFilePath has no bad blocks according to badblocks.xml. Should not overwrite... Exiting." -ForegroundColor "Red";
			exit 3;
		}	
	
        # When using $BufferGranularSize (or other gradual retry logic), it could be writting different size blocks to badblocks file. What would be the implications if it did?
		Assert {($DestinationFileBadBlocks | Measure-Object -Average -Property Size).Average -eq $BufferSize } "Block sizes do not match between source and destination file. Can not continue." # This is currently an implementation shortcomming.
			
	}
}

# Making buffer
$Buffer = New-Object -TypeName System.Byte[] -ArgumentList $BufferSize;

# Making container for storing missread offsets.
$UnreadableBlocks = @();

# Making filestreams
$SourceStream = $SourceFile.OpenRead();
$DestinationStream = $DestinationFile.OpenWrite();
if (-not $?) {exit 4;}

# Measure time between progress reports to avoid wasting resources (and adding wait times for the UI to redraw)
[TimeSpan] $ReportEvery = New-TimeSpan -Seconds 10; # Wait 10 seconds before first report, then every 3
[TimeSpan] $ReportWaitAfterward = New-TimeSpan -Seconds 3; # Update every 3 seconds after first report
[TimeSpan] $ThroughputRefreshEvery = $ReportEvery - (New-TimeSpan -Seconds 2); # Wait 8+ seconds to recalculate throuput
[Diagnostics.Stopwatch] $sw = [Diagnostics.Stopwatch]::StartNew();
[TimeSpan] $LatestReportedAt = $sw.Elapsed;
[TimeSpan] $LatestThroughputReportedAt = $LatestReportedAt;
[int64] $InitialPosition = $Position # Remember initial $Position value (before it is changed during iterations) for final throughput calc
[int64] $ThroughputLastPosition = $Position; # Initial position to calculate throughput
[float] $ThroughputLast = 0; # MB/s throughput as of last refresh
[int64] $GranularOverallBadSizeTotal = 0;

# Measure time between progress reports to avoid wasting resources (and adding wait times for the UI to redraw)
[TimeSpan] $ReportEvery = New-TimeSpan -Seconds 10; # Wait 10 seconds before first report, then every 3
[TimeSpan] $ReportWaitAfterward = New-TimeSpan -Seconds 3; # Update every 3 seconds after first report
[TimeSpan] $ThroughputRefreshEvery = $ReportEvery - (New-TimeSpan -Seconds 2); # Wait 8+ seconds to recalculate throuput
[Diagnostics.Stopwatch] $sw = [Diagnostics.Stopwatch]::StartNew();
[TimeSpan] $LatestReportedAt = $sw.Elapsed;
[TimeSpan] $LatestThroughputReportedAt = $LatestReportedAt;
[int64] $InitialPosition = $Position # Remember initial $Position value (before it is changed during iterations) for final throughput calc
[int64] $ThroughputLastPosition = $Position; # Initial position to calculate throughput
[float] $ThroughputLast = 0; # MB/s throughput as of last refresh
[int64] $GranularOverallBadSizeTotal = 0;

if ($PositionEnd -le -1) {$PositionEnd = $SourceStream.Length}

# Copying starts here
Write-Host "Starting copying of $SourceFilePath..." -ForegroundColor "Green";

[bool] $ReadSuccessful = $false;

while ($Position -lt $PositionEnd) {

    # Report progress so far
    # Only report every so often, to avoid flicker and wasted processing/wait times
    if( ($LatestReportedAt + $ReportEvery) -le $sw.Elapsed) {

        # Update throughput calculation
        if( ($LatestThroughputReportedAt + $ThroughputRefreshEvery) -le $sw.Elapsed) {
            $ThroughputLast = [math]::Round(($Position - $ThroughputLastPosition) / 1024 / 1024 / ($sw.Elapsed - $LatestThroughputReportedAt).TotalSeconds, 2);
            $LatestThroughputReportedAt = $sw.Elapsed;
            $ThroughputLastPosition = $Position;
        }

        # Update progress bar(s)
        Force-Copy-ProgressReport -Position $Position -PositionEnd $PositionEnd -LatestThroughput $ThroughputLast `
            -DetailedStatus "Reading block ($BufferSize bytes) at position $Position" 

        # Update interval variables
        $LatestReportedAt = $sw.Elapsed;
        $ReportEvery = $ReportWaitAfterward; # Switch to 3 seconds after the initial wait
    }

	if ($NewDestinationFile -or 
	   ($PositionMarkedAsBad = $DestinationFileBadBlocks | % {if (($_.Offset -le $Position) -and ($Position -lt ($_.Offset + $_.Size))) {$true;}})) {
			
			if (($Position -eq 0) -or -not $LastReadFromSource) {Write-Host "Started reading from source file at offset $Position." -ForegroundColor "DarkRed";}
			$LastReadFromSource = $true;

            [bool] $GranularLogicUsed = $false;

			# Force read a block from source
            if (($BufferGranularSize -gt 0) -and ($MaxRetries -gt 0) ) {
                # Try once w/o retries
                $ReadLength = Force-Read -Stream $SourceStream -Position $Position -Buffer ([ref] $Buffer) -Successful ([ref] $ReadSuccessful) -MaxRetries 0;
                
                # If failed, then go again retrying with smaller buffer
    			if (-not $ReadSuccessful) {
                    # Granular logic could probably use more testing (extreme cases, like error in last block of file).
                    # Maybe try and use Holodeck (now open source), see http://stackoverflow.com/questions/4430591/simulating-file-errors-e-g-error-access-denied-on-windows

                    # Flag we are switched to smaller buffer (so it doesn't write to output in outer if)
                    $GranularLogicUsed = $true;

                    # Better way to log it, actually granular? Or just ignore the outer buffer size for badblocks purposes (it's unlikely that people will be mixing versions of the script with prior badblock with different sizes)
				    # $UnreadableBlocks += New-Block  -OffSet $Position -Size $ReadLength;

                    Write-Host "Switching to granular logic at $Position." -ForegroundColor "DarkGreen";

                    # Allocate granular buffer
                    $GranularBuffer = New-Object -TypeName System.Byte[] -ArgumentList $BufferGranularSize;

                    # Could probably try and refactor with outer loop (and/or refactor conditional), but it could be error prone. For now better duplicate some of the outer loop logic with local variables
                    # Could also try and do it inside Force-Read (and might be more elegant), but that might have other issues
                    # Maybe better yet, could refactor into a recursive version, so it would gradually lower the granular buffer size, so it doesn't loose all the speed when it hits an error
                    [int64] $GranularPosition = $Position;
                    [int64] $GranularLastPosition = [math]::Min([int64] $Position + $BufferSize, $PositionEnd);
                    [int64] $GranularReadLength = -1;
                    [int64] $GranularReadLengthTotal = 0;
                    [bool] $GranularReadSuccessful = $false;

                    while ($GranularPosition -lt $GranularLastPosition) {
                        # Update progress report
                        if( ($LatestReportedAt + $ReportEvery) -le $sw.Elapsed) {
                            if( ($LatestThroughputReportedAt + $ThroughputRefreshEvery) -le $sw.Elapsed) {
                                $ThroughputLast = [math]::Round(($GranularPosition - $ThroughputLastPosition) / 1024 / 1024 / ($sw.Elapsed - $LatestThroughputReportedAt).TotalSeconds, 2);
                                $LatestThroughputReportedAt = $sw.Elapsed;
                                $ThroughputLastPosition = $GranularPosition;
                            }

                            Force-Copy-ProgressReport -Position $GranularPosition -PositionEnd $PositionEnd  -LatestThroughput $ThroughputLast `
                                -DetailedStatus "Granular reading $BufferGranularSize bytes block at position $GranularPosition"

                            $LatestReportedAt = $sw.Elapsed;
                            $ReportEvery = $ReportWaitAfterward;
                        }

                        $GranularReadLength = Force-Read -Stream $SourceStream -Position $GranularPosition -Buffer ([ref] $GranularBuffer) -Successful ([ref] $GranularReadSuccessful) -MaxRetries ($MaxRetries);

                        if (-not $GranularReadSuccessful) {
                            $GranularOverallBadSizeTotal += $GranularReadLength;
                        }

                        # Here we could log a more granular version of badblocks
                        $UnreadableBlocks += New-Block  -OffSet $GranularPosition -Size $GranularReadLength;

			            # Write to destination file.
			            $DestinationStream.Position = $GranularPosition;
    		            $DestinationStream.Write($GranularBuffer, 0, $GranularReadLength);

                        $GranularPosition += $GranularReadLength;
                        $GranularReadLengthTotal += $GranularReadLength;
                    }

                    $ReadLength = $GranularReadLengthTotal;

                    # Does it need an escape clause like $LastReadFromSource (see below)
                }

            } else {
                
                # Original logic w/o granular buffer
			    $ReadLength = Force-Read -Stream $SourceStream -Position $Position -Buffer ([ref] $Buffer) -Successful ([ref] $ReadSuccessful) -MaxRetries $MaxRetries;		

            }

            if (-not $GranularLogicUsed) {
			    if (-not $ReadSuccessful) {
				    $UnreadableBlocks += New-Block  -OffSet $Position -Size $ReadLength;
			    }
				
			    # Write to destination file.
			    $DestinationStream.Position = $Position;
    		    $DestinationStream.Write($Buffer, 0, $ReadLength);
            }

			
	} else {
	
			if ($Position -eq 0 -or $LastReadFromSource) {Write-Host "Skipping from offset $Position." -ForegroundColor "DarkGreen";}
			$LastReadFromSource = $false;
			
			# Skipping block.
			$ReadLength = $BufferSize;
		
	}
	
	$Position += $ReadLength; # adjust position

}

$SourceStream.Dispose();
$DestinationStream.Dispose();

$sw.Stop();

if ($UnreadableBlocks) {
	
	# Write summaryamount of bad blocks.
    if ($BufferGranularSize -gt 0) {
	    Write-Host "Up to $GranularOverallBadSizeTotal bytes are bad." -ForegroundColor "Magenta";
    } else {
	    Write-Host "$(($UnreadableBlocks | Measure-Object -Sum -Property Size).Sum) bytes are bad." -ForegroundColor "Magenta";
    }
	
	# Export badblocks.xml file.
	Export-Clixml -LiteralPath ($DestinationFileBadBlocksPath) -InputObject $UnreadableBlocks;

} elseif (Test-Path -LiteralPath $DestinationFileBadBlocksPath) { # No unreadable blocks and badblocks.xml exists.
	
	Remove-Item -LiteralPath $DestinationFileBadBlocksPath;
}

# Set creation and modification times
$DestinationFile.CreationTimeUtc = $SourceFile.CreationTimeUtc;
$DestinationFile.LastWriteTimeUtc = $SourceFile.LastWriteTimeUtc;
$DestinationFile.IsReadOnly = $SourceFile.IsReadOnly;

[string] $FinalTimeStr = $sw.Elapsed.ToString();
[float] $ThroughputMBperS = [math]::Round( ($PositionEnd - $InitialPosition) / 1024 / 1024 / $sw.Elapsed.TotalSeconds, 2);
Write-Host "Copied $PositionEnd bytes in $FinalTimeStr ($ThroughputMBperS MB/s)" -ForegroundColor "Green";
Write-Host "Finished copying $SourceFilePath!`n" -ForegroundColor "Green";

# Return specific code.
if ($UnreadableBlocks) {
	exit 1;
} else {
	exit 0;
}

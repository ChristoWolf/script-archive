<#

.SYNOPSIS
This script backups folders as zip-files.

Author: Christoph Wolf

.DESCRIPTION
This Powershell script is used to backup the folder (and its contents)
specified by $BackupSource to $BackupDestination.
For this, the script checks if the specified directories exist.
Note: Using the -DeleteOldBackups deletes all directories
in the destination for which the name is of a certain form!
Currently, this script is limited to directories of size < 2GB!

#>

[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)]
    [string] $BackupSource,
    [Parameter(Mandatory = $true)]
    [string] $BackupDestination,
    [Parameter(Mandatory = $true)]
    [bool] $DeleteOldBackups
)

$isToCancel = $false
$sourceExists = Test-Path $BackupSource
if (!($sourceExists)) {
    Write-Host "Directory $BackupSource does not exist!"
    $isToCancel = $true
}

$destExists = Test-Path $BackupDestination
if (!($destExists)) {
    Write-Host "Directory $BackupDestination does not exist!"
    $isToCancel = $true
}

if ($isToCancel) {
    return $false
}

if ($DeleteOldBackups) {
    try {
        Remove-Item "$BackupDestination`\*_Backup_*.zip" -Recurse -Force
    } catch [Exception] {
        Write-Host "Failed to delete old backups in directory $BackupDestination!"
        Write-Host $_.Exception|Format-List -Force
        return $false
    }
}

$TimeStamp = get-date -f yyyyMMddhhmm
$HostName = [System.Net.Dns]::GetHostName()
$SourceName = Split-Path $BackupSource -Leaf
$DestinationPath = "$BackupDestination`\$SourceName`_$HostName`_Backup_$TimeStamp"

try {
    Compress-Archive -Path $BackupSource -DestinationPath $DestinationPath -Force
} catch [Exception] {
    Write-Host "Failed to copy content of directory $BackupSource to $DestinationPath!"
    Write-Host $_.Exception|Format-List -Force
    return $false
}

Write-Host "Backup finished successfully!"

return $true
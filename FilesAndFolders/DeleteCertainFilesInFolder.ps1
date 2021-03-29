[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)]
    [string] $FileNameLike,
    [Parameter(Mandatory = $true)]
    [string] $FolderPath
)

if (!(Test-Path -Path $FolderPath)) {
    Write-Host "Folder not found, aborting mission."
    return -1;
}

$files = Get-ChildItem -LiteralPath $FolderPath -File -Filter "*$FileNameLike*" | Remove-Item -Confirm

Write-Host "Deleted files: $files"
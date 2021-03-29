# TODO: Rewrite script to instead just take a credentials object.
[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)]
    [string] $VMName,
    [Parameter(Mandatory = $true)]
    [string] $ESXIHost,
    [Parameter(Mandatory = $true)]
    [string] $ESXIUsername,
    [Parameter(Mandatory = $true)]
    [string] $ESXIPassword
    [Parameter(Mandatory = $true)]
    [int]$DisconnectLengthMS
)

Connect-VIServer -Server $ESXIHost -User $ESXIUsername -Password $ESXIPassword

Write-Host "------------------------------------------------------------------------------------------" -ForegroundColor DarkMagenta
Write-Host "VMName: $VMName, DisconnectLengthMS: $DisconnectLengthMS"

Get-Date -Format o
Get-NetworkAdapter -VM $VMName | Set-NetworkAdapter -Connected:$false -Confirm:$false -WhatIf
if ($DisconnectLengthMS -gt 0) {
    Start-Sleep -Milliseconds $DisconnectLengthMS
}
Get-NetworkAdapter -VM $VMName | Set-NetworkAdapter -Connected:$true -Confirm:$false -WhatIf
Get-Date -Format o
Write-Host "------------------------------------------------------------------------------------------" -ForegroundColor DarkMagenta
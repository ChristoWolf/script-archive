# TODO: Rewrite script to instead just take a credentials object.
[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)]
    [string] $ESXIHost,
    [Parameter(Mandatory = $true)]
    [string] $ESXIUsername,
    [Parameter(Mandatory = $true)]
    [string] $ESXIPassword
)

$ESXIPassword = ConvertTo-SecureString -String $ESXIPassword -AsPlainText -Force

if ((Get-Module VMware*) -eq $null) {
    Find-Module -Name VMware.PowerCLI
    Install-Module -Name VMware.PowerCLI -Scope CurrentUser -Force
    if ((Get-Module VMware*) -eq $null) {
        Write-Host "Failed to install PowerCLI-Modules"
        return 99
    }
}

$ESXICredential = New-Object –TypeName "System.Management.Automation.PSCredential" –ArgumentList $ESXIUsername, $ESXIPassword
$Server = Connect-VIServer $ESXIHost -Credential $ESXICredential -Force

$Content = Get-Inventory -Server $Server | Out-String

Write-Host $Content
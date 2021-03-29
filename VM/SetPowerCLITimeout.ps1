[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)]
    [int] $Seconds
)

if ($Seconds -le 0) {
    Write-Host "Parameter Seconds needs to be > 0!"
    return 99
}

if ((Get-Module VMware*) -eq $null) {
    Find-Module -Name VMware.PowerCLI
    Install-Module -Name VMware.PowerCLI -Scope CurrentUser -Force
    if ((Get-Module VMware*) -eq $null) {
        Write-Host "Failed to install PowerCLI-Modules"
        return 99
    }
}

Set-PowerCLIConfiguration -WebOperationTimeoutSeconds $Seconds
[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)]
    [string] $Name
)

while ($true) {
    if ((Get-Process -Name $Name -ErrorAction SilentlyContinue) -ne $null) {
        $Timer = Get-Random -Maximum 10000 -Minimum 100
        Start-Sleep -m $Timer
        Stop-Process -Name $Name -Force
        Write-Host "Killed all processes named $Name!"
    }
}
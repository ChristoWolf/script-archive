[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)]
    [string]$VMName1,
    [Parameter(Mandatory = $true)]
    [int]$DisconnectLengthMS1,
    [Parameter(Mandatory = $true)]
    [string]$VMName2,
    [Parameter(Mandatory = $true)]
    [int]$DisconnectLengthMS2
)

$ParentPath = Split-Path -Path $MyInvocation.MyCommand.Path
$OtherScriptPath = Join-Path -Path $ParentPath -ChildPath "DisconnectReconnectVMNetwork.ps1"

if (!(Test-Path -Path $OtherScriptPath)) {
    Write-Host "Failed to find required script in current folder!"
    return
}

$Job1 = Start-Job -FilePath "$OtherScriptPath" -ArgumentList @($VMName1,$DisconnectLengthMS1)
$Job2 = Start-Job -FilePath "$OtherScriptPath" -ArgumentList @($VMName2,$DisconnectLengthMS2)
$Jobs = @($Job1,$Job2)
Wait-Job $Jobs
$Jobs | Receive-Job
# TODO: Rewrite script to instead just take a credentials object.
[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true)]
    [string] $VMName,
    [Parameter(Mandatory = $true)]
    [string] $ESXIHost,
    [Parameter(Mandatory = $true)]
    [string] $ESXIUsername,
    [Parameter(Mandatory = $true)]
    [string] $ESXIPassword
)

if ((Get-Module VMware*) -eq $null) {
    Find-Module -Name VMware.PowerCLI
    Install-Module -Name VMware.PowerCLI -Scope CurrentUser -Force
    if ((Get-Module VMware*) -eq $null) {
        Write-Host "Failed to install CLI-Modules"
        return 99
    }
}

$ESXIPassword = ConvertTo-SecureString -String -AsPlainText -Force
$ESXICredential = New-Object –TypeName "System.Management.Automation.PSCredential" –ArgumentList $ESXIUsername, $ESXIPassword
$Server = Connect-VIServer $ESXIHost -Credential $ESXICredential -Force

$VMEvents = Get-VIEvent $VMName

foreach ($row in $VMEvents) {
    $created = $row.CreatedTime
    $user = $row.Username
    $message = $row.FullFormattedMessage
    $vmhost = $row.Host.Name
    $source = $row.SourceVm.Name

    Write-Host "`n-------------------------------------------------------------------" -ForegroundColor Green
    if ($row.Template -eq $true) {
        Write-Host "Template name: $VMName"
    } else {
        Write-Host "VM name: $VMName"
    }
    Write-Host "Creation time: $created"
    Write-Host "Source: $source"
    Write-Host "VM host: $vmhost"
    Write-Host "User: $user"
    Write-Host "Message: $message"
    Write-Host "-------------------------------------------------------------------" -ForegroundColor Green
}
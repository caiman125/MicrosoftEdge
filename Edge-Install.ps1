param
(
[parameter(Mandatory=$true)]
[ValidateNotNullOrEmpty()]$MSIName,
[parameter(Mandatory=$true)]
[ValidateNotNullOrEmpty()]$ChannelID
)
# Registry value name is in the format "Update<{ChannelID}> where ChannelID is the GUID
Set-Variable -Name "AutoUpdateValueName" -Value "Update$ChannelID" -Option Constant
Set-Variable -Name "RegistryPath" -Value "HKLM:\SOFTWARE\Policies\Microsoft\EdgeUpdate" -
Option Constant
# Test if the registry key exists. If it doesn't, create it
$EdgeUpdateRegKeyExists = Test-Path -Path $RegistryPath
if (!$EdgeUpdateRegKeyExists)
{
New-Item -Path $RegistryPath
}
# See if the autoupdate value exists
if (!(Get-ItemProperty -Path $RegistryPath -Name $AutoUpdateValueName -ErrorAction
SilentlyContinue))
{

New-ItemProperty -Path $RegistryPath -Name $AutoUpdateValueName -Value 0 -PropertyType
DWord
}
$AutoupdateValue = (Get-ItemProperty -Path $RegistryPath -Name
$AutoUpdateValueName).$AutoUpdateValueName
# If the value is not set to 0, auto update is not turned off, this is a failure
if ($AutoupdateValue -ne 0)
{
Write-Host "Autoupdate value set incorrectly"
return -1
}
# Else install the Edge MSI
else
{
return (Start-Process msiexec.exe -Wait -ArgumentList "/i $MSIName /q").ExitCode
}

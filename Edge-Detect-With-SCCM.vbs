Function Get-RdpSessions
{
$processinfo = Get-WmiObject -Query "select * from win32_process where name='explorer.exe'"

$processinfo | ForEach-Object { $_.GetOwner().User } | Sort-Object -Unique | ForEach-Object { New-
Object psobject -Property @{Computer=$computername;LoggedOn=$_} }

}
$session = Get-RdpSessions | select -expand LoggedOn

$drive = $Env:HOMEDRIVE
$existe = 0
if(Test-Path -path ("C:\Program Files\Microsoft\Edge"))
{
$existe = 1
}
$existe2 = 0
if (Test-Path -path ($drive + "\Users\" + $session + "\AppData\Local\Microsoft\Edge"))
{
$existe2 = 1
}
$existe3 = 0
if(Test-Path -path ("C:\Program Files (x86)\Microsoft\Edge\"))
{
$existe3 = 1
}

if(($existe -eq 1) -or ( $existe2 -eq 1) -or ($existe3 -eq 1))

{
Write-Host "Edge is installed"
Exit 0
}
else{
}

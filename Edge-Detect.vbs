CurrectUser = ""
existe1 = 0
existe2 = 0
existe3 = 0
strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set colProcessList = objWMIService.ExecQuery("Select * from Win32_Process Where Name =
'explorer.exe'")

For Each objProcess in colProcessList
objProcess.GetOwner strUserName, strUserDomain
CurrectUser = strUserName

Next
Set WSHShell = CreateObject("WScript.Shell")
vHomeDrive = WSHShell.ExpandEnvironmentStrings("%HOMEDRIVE%")
Set objFSO = CreateObject("Scripting.FileSystemObject")
If objFSO.FolderExists(vHomeDrive & "\Users\" & CurrectUser &
"\AppData\Local\Microsoft\Edge\Application") Then

existe1 = 1

End If
If objFSO.FolderExists("C:\Program Files (x86)\Microsoft\Edge\") Then

existe2 = 1

End If
If objFSO.FolderExists("C:\Program Files\Microsoft\Edge") Then

existe3 = 1

End If
if existe1 = 1 or existe2=2 or existe3=1 then
WScript.StdOut.Write "Edge is installed"
WScript.Quit(0)

else

WScript.Quit(0)

end if

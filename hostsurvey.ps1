#System Details 

# Information about System Date/Time
Write-Host System Date/time
Get-Date

# System Timezone
Write-Host Timezone 
Get-TimeZone

# OS information, including hostname 
Write-Host OS info
Get-ComputerInfo -Property "*name" ,"osversion"

# Recently Installed applications both 32/64bit
Write-Host "applications"
Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | Select-Object -Property Displayname, installdate | Sort-Object -Descending


#Users/Groups

# last local user logon
Write-Host "local user logon"
Get-LocalUser |select name, lastlogon
 
# administrator group members
Write-host "admin group members"
Get-LocalGroupMember -Group "Administrators"


#Connections


# interface information
write-host "net interfaces:"
Get-NetIPInterface | where-object {$_.dhcp -eq "enabled" -or $_.ConnectionState -eq "connected"} | select InterfaceAlias, AddressFamily


# network connections 
write-host "net connections:"
Get-NetTCPConnection | Where-Object {$_.state -eq "established" -or $_.state -eq "listen"} | Select-Object -Property InstanceID, CreationTime, LocalAddress, LocalPort, OwningProcess, RemoteAddress, RemotePort, State


#processes/services 

# process information including name, PID, PPID and Path
write-host "process information"
gwmi win32_process | select Name, processID, Parentprocessid, path

# recently created tasks
Write-Host "recently created tasks"
Get-ScheduledTask | Sort-Object descending | Select-Object -Property TaskName, Description, State, URI, Version, TaskPath, SecurityDescriptor

# run keys
Write-Host "run keys"
Get-ChildItem -Path HKCU:\ | Select-Object Name

# temp folders
Write-Host "temp folders"
Get-ChildItem -Path $tempfolder | Select-Object -Property LastWriteTime, Name  

# named pipes 
Write-Host "named pipes"
get-childitem \\.\pipe\
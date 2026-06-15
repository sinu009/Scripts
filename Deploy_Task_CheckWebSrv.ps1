#This script will create ScheduledTask ,before running the script copy both the script to c:\Temp folder in target machine ,run this script as Administrator

$action = New-ScheduledTaskAction -Execute 'PowerShell.exe' `
  -Argument '-ExecutionPolicy Bypass -File "C:\Temp\CheckWebSrv.ps1"'
$trigger = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "CheckWebSrv" -User "SYSTEM" -RunLevel Highest

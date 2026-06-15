
# Import the IIS Administration module
Import-Module WebAdministration

# Get all app pools, filter for stopped ones, and start them
$stoppedPools = Get-ChildItem IIS:\AppPools | Where-Object { $_.state -ne "Started" }

$LogPath = "C:\inetpub\logs\CheckWebSrv.log"



foreach ($pool in $stoppedPools) {
    Write-output "$(Get-Date) `t` $($pool.name) was failed to start" >> $LogPath
    Start-WebAppPool -Name $pool.name
    Start-Sleep -Seconds 3
    $AppPoolState = Get-WebAppPoolState -Name $pool.name
   if ($AppPoolState.Value -eq "Started")
   { 
   
   Write-output "$(Get-Date) `t` $($pool.name) started successfully" >> $LogPath  }

   else {  Write-output "$(Get-Date) `t` $($pool.name) is not started please check the settings" >> $LogPath  }
} 
  
if ($stoppedPools.Count -eq 0) {
    Write-output "$(Get-Date) `t` ALL IIS AppPools  started successfully" >> $LogPath
}





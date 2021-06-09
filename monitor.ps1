# Should be in the miner's folder.

While ($true)
{		
	$name = "nanominer"
	$process = Get-Process $name -ErrorAction SilentlyContinue
	
	if (!$process) {
		Write-Output "STARTING... $(Get-Date -Format '(yyyy/MM/dd HH:mm)')" 
		
		Start-Process -Wait -FilePath cmd -ArgumentList "/k .\$name.exe"
	}	
	else {
		Write-Output "RUNNING... $(Get-Date -Format '(yyyy/MM/dd HH:mm)')"
	}     
    Start-Sleep 30
}

# It should be placed in the miner's folder.

Function MinerStartUp
{	
	if(Get-Process cmd -ErrorAction SilentlyContinue){
		Stop-Process -Name cmd -Force
	}
    Write-Output "$(Get-Date -Format 'yyyy/MM/dd HH:mm:ss') (MINER STARTED)"
	Start-Process -FilePath cmd -ArgumentList "/k .\nanominer.exe"
}

while($true){
    if(Get-Process nanominer -ErrorAction SilentlyContinue){
        Write-Output "$(Get-Date -Format 'yyyy/MM/dd HH:mm:ss') (UP)"
    }else {
		Write-Output "$(Get-Date -Format 'yyyy/MM/dd HH:mm:ss') (DOWN)"
        MinerStartUp
	}
	Start-Sleep -s 15
}

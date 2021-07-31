# It should be placed in the miner's folder.

$api = "https://api.nanopool.org/v1/eth/"
$method = "reportedhashrates/"
$wallet = "CHANGE_WALLET_HASH"
$url = [System.String]::Concat($api,$method,$wallet)
$miner = "nanominer"
$fileConfig = Get-Content -Path config.ini | Select-String -pattern "rigName"
$rigName = $fileConfig -split "="

$worker = $rigName[1]
$threshold = "CHANGE_MONITOR_THRESHOLD"

$data = (Invoke-RestMethod -Uri $url | select  data).data

$result = $data | ?{ $_.worker -eq $worker } | Select -ExpandProperty "hashrate"

Function MinerStartUp
{	
	if(Get-Process cmd -ErrorAction SilentlyContinue){
		Stop-Process -Name cmd -Force
	}
    	Write-Output "$(Get-Date -Format 'yyyy/MM/dd HH:mm:ss') (MINER STARTED)"
	Start-Process -FilePath cmd -ArgumentList "/k .\$miner.exe"
}

while($true){

	if($result -lt $threshold){
		Write-Output "$(Get-Date -Format 'yyyy/MM/dd HH:mm:ss') $result (DOWN)"
        MinerStartUp
	}
	else {
		Write-Output "$(Get-Date -Format 'yyyy/MM/dd HH:mm:ss') $result (UP)"
		
	}
	Start-Sleep -s 900
}

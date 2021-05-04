# Logging Location, Trace/Ping Desto
$lpath = "C:\Users\lpower\OneDrive - Sinclair Broadcast Group, Inc\!Profile\Documents\RouteLogging\"
$dest1 = "api-wlc-dal.watsonmedia.ibm.com"
$dest2 = "api-wlc-wdc.watsonmedia.ibm.com"

$timestamp = Get-Date
#$trace = Test-NetConnection -ComputerName $desto -InformationLevel "Detailed" -TraceRoute
$dpath = "$lpath\$($timestamp.Year)\$($timestamp.Month)\$($timestamp.Day).txt"

function Get-RouteStats {
    param (
        $desto
    )
    if(-not (Test-Path $dpath)) {
        New-Item -Path $lpath\$($timestamp.Year)\$($timestamp.Month) -Force -ItemType Directory
        New-Item -Path $dpath -Force -ItemType File -Value $_
    }
    $rt = TRACERT.EXE $desto
    "$(Get-Date): " | Out-File -FilePath "$dpath" -Encoding ascii -Append -Force
    $rt | Out-File -FilePath "$dpath" -Encoding ascii -Append -Force
}

#"$($timestamp): " | Out-File -FilePath "$lpath\$($timestamp.Year)\$($timestamp.Month)\$($timestamp.Day).txt" -Encoding ascii -Append -Force
#$trace | Out-File -FilePath "$lpath\$($timestamp.Year)\$($timestamp.Month)\$($timestamp.Day).txt" -Encoding ascii -Append -Force

Get-RouteStats $dest1
Get-RouteStats $dest2
"-------------------------------------" | Out-File -FilePath "$dpath" -Encoding ascii -Append -Force
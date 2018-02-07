#samples from
##https://gallery.technet.microsoft.com/scriptcenter/dd9eb0c5-48f8-4f8c-8051-7b9f9400d77d
##https://qiita.com/webdevjp/items/9e693d84517cec81c3e7

#$ipaddresses = (cat "ipaddress.txt")

$ipaddresses = @"
8.8.8.8
8.8.4.4
"@  -split "`r`n"

$rows = @("ip,hostname")
#$hostnames = @()
$result = $false

foreach ($ip in $ipaddresses)
{
  try { $tmphostname = [System.Net.Dns]::GetHostEntry($ip).Hostname }
  catch [Exception] { $tmphostname = "" }
  $rows += $ip + "," + $tmphostname
  Start-Sleep -m 500
   }

$result = $rows | ConvertFrom-Csv

#$result = $rows | ConvertFrom-Csv | Out-GridView
#$rows | ConvertFrom-Csv | Export-Csv "result.csv" -NoTypeInformation

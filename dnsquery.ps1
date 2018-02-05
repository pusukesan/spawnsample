#samples from
##https://gallery.technet.microsoft.com/scriptcenter/dd9eb0c5-48f8-4f8c-8051-7b9f9400d77d
##https://qiita.com/webdevjp/items/9e693d84517cec81c3e7

$hostnames = (cat "hostnames.txt")

$rows = @("hostname,ip")
$ips = @()
$result = $false

Function Get-DnsEntry($iphost)  
{  
 If($ipHost -match "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$")
  {
   try { [System.Net.Dns]::GetHostEntry($iphost).HostName } 
   catch [Exception]
       { return "non-existant IPaddr" }  
     #{ $ips = @("")
   }

 #ElseIf( $ipHost -match "^.*\.\.*")  
 ElseIf( $ipHost -match "^.*\.\.*")  
   {
    try { [System.Net.Dns]::GetHostEntry($iphost).AddressList[0].IPAddressToString }
    catch [Exception]
        { return "non-existant Host" }  
        #{ $ips = @("") }

 #ELSE { Throw "Specify either an IP V4 address or a hostname" }  
   } # Get-Whatif 関数の終わり  
}  
#foreach ($hostname in $hostnames) {
#  get-dnsentry($hostname)

#$rows += $hostname + ...  +=によって配列に要素が追加される
#?はwhere-object

#$ips = @()　初期化
#$ips += [system.net.dns:: ...で配列に要素が追加される

#foreach ( $ip in $ips) { $rows += $hostname + "," + $ips }

#$rows | ConvertFrom-Csv | Export-Csv "result.csv" -NoTypeInformation
#$rows | ConvertFrom-Csv | Out-GridView

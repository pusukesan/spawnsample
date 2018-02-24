$name = @("name")
$ipaddresses = Get-Content ipaddress.csv #IPアドレスの列を持っているcsvを読み込む。ヘッダが存在すること。
$items = ($(Get-Content test.txt) -replace "`t", "`n").split("`n") #セルをテキストファイルに貼り付けたものを読み込む
$count = 1

'<?xml version="1.0" encoding="UTF-8"?/>' | out-file result.xml -Encoding UTF8

foreach ( $item in $items ) {
    if( $item -match  "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$") 
    { '<ip="'+$ipaddresses[$count]+'"name=""state="">' | out-file result.xml -append -Encoding UTF8 }
    elseif( $item -eq "N/A" )
    { '<ip="'+$ipaddresses[$count]+'"name=""state="">' | out-file result.xml -append -Encoding UTF8 }
    else
    { '<ip="'+$ipaddresses[$count]+'"name="'+$item+'"state="static">' | out-file result.xml -append -Encoding UTF8 }
    $count+=1
    }


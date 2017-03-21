#echelon.PS1
[System.Collections.ArrayList]$wordlist = (Invoke-Webrequest -Uri https://raw.githubusercontent.com/yabona/general/master/__NSAKEY).Content.Split(",")
while ($true) {
    $engine = 1..6|get-random  
    switch ($engine) {
        1 {$search = "https://google.ca/search?q=" ; write-verbose "using GOOGLE" -Verbose ; break}
        2 {$search = "https://www.bing.com/search?q=" ; Write-Verbose "using BING" -Verbose ; break}
        3 {$search = "https://search.yahoo.com/search;?p=" ; Write-Verbose "using YAHOO" -Verbose ; break}
        4 {$search = "http://www.ask.com/web?q=" ; Write-Verbose "using ASK" -Verbose ; break}
        5 {$search = "https://yandex.com/search/?text="; Write-Verbose "Using YANDEX" -Verbose; break}
        6 {$search = "http://baidu.com/s?ie=ie=utf-8&wd="; Write-Verbose "Using BAIDU" -Verbose; break}
    }
    $num = 1..4|Get-random
    for ($j = 0; $j -lt $num; $j++) {
        $search += [string]($wordlist[(Get-random -Maximum $wordlist.count)]).replace(' ','%20')
    } 
    saps iexplore.exe $search 
    Write-Verbose $search -Verbose
    Start-Sleep -Milliseconds $(2000..10000|Get-Random)
    Get-Process iexplore | % { $_.CloseMainWindow() }
} 

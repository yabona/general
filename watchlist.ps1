#watchlist.PS1
# (C) Yabones 2016 
# just fuccin with ya, this script is free as in FREEDOM do what you want with it
[System.Collections.ArrayList]$wordlist = (Invoke-Webrequest -Uri https://raw.githubusercontent.com/yabona/general/master/__NSAKEY).Content.Split(",")
while ($true) {
    $engine = 1..5|get-random  
    switch ($engine) {
        1 {$search = "https://google.ca/search?q="}
        2 {$search = "https://www.bing.com/search?q="}
        3 {$search = "https://search.yahoo.com/search;?p="}
        4 {$search = "http://www.ask.com/web?q="}
        5 {$search = "http://baidu.com/s?ie=ie=utf-8&wd="}
    }
    $num = 1..5|Get-random
    for ($j = 0; $j -lt $num; $j++) {
        $search += [string]($wordlist[(Get-random -Maximum $wordlist.count)]).replace(' ','%20')
    } 
    saps iexplore.exe $search 
    Write-Verbose $search -Verbose
    Start-Sleep -Milliseconds $(2000..8000|Get-Random)
    Get-Process iexplore | % { $_.CloseMainWindow() }
} # smack this bitch right up :: fuck you NSA, CIA, ZUCC, russia, and all you other enemies of freedom! 

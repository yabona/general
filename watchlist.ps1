#watchlist.PS1
[System.Collections.ArrayList]$wordlist = (Invoke-Webrequest -Uri https://raw.githubusercontent.com/yabona/general/master/__NSAKEY).Content.Split(",")
while ($true) {
    $engine = 1..5|get-random  
    switch ($engine) {
        1 {$search = "https://google.ca/search?q="}
        2 {$search = "https://www.bing.com/search?q="}
        3 {$search = "https://search.yahoo.com/search;?p="}
        4 {$search = "https://www.ask.com/web?q="}
        5 {$search = "https://https://baidu.com/s?ie=ie=utf-8&wd="}
    }
    $num = 1..5|Get-random
    for ($j = 0; $j -lt $num; $j++) {
        $search += [string]($wordlist[(Get-random -Maximum $wordlist.count)]).replace(' ','%20')
    } 
    Invoke-WebRequest -Uri $search -verbose
} 

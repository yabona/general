#watchlist.PS1
[System.Collections.ArrayList]$wordlist = (Invoke-Webrequest -Uri https://raw.githubusercontent.com/yabona/general/master/__NSAKEY).Content.Split(",")
while ($true) {
    $search = "https://google.ca/search?q="
    $num = 1..5|Get-random
    for ($j = 0; $j -lt $num; $j++) {
        $search += [string]($wordlist[(Get-random -Maximum $wordlist.count)]).replace(' ','%20')
    } 
    Invoke-WebRequest -Uri $search -verbose
} 

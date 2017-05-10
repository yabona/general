# download wordlist and Cat it together to form a single text file with 4 billion passwords... 
# Source: github.com/berzerk0/Probable-Wordlists
# Make a directory with write access at C:\Temp before running this script. 
# It will take up to four hours to download the lists. Total size is over 20 Gibibytes 

$htmlRaw = (Invoke-WebRequest https://github.com/berzerk0/Probable-Wordlists/tree/master/Real-Passwords/Sorted-into-Chunks).links 

# Link href locations 
$top2billion = ($htmlRaw | ? {$_.innerHtml -like "Top2Billion-Probable-*"}).href

# cut the last field from the URL 
$filelist = $top2billion | % {$_.split("/")[7] }

# web location of source directory 
$sourceDir = [String] "https://raw.githubusercontent.com/berzerk0/Probable-Wordlists/master/Real-Passwords/Sorted-into-Chunks/"

for ($i=0; $i -lt $filelist.length; $i++) {
    # set up item web location 
    $j = "$sourceDir$($filelist[$i])"

    # output for nerds... 
    Write-Verbose $filelist[$i] -Verbose 
    Write-Output "$([system.math]::Round(($i/$filelist.length*100),2)) % complete..."

    # download file
    Invoke-WebRequest -Uri $j -OutFile "C:\temp\$($filelist[$i])"
}

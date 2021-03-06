######################
## Get-Memes script ##
######################

# yabones 2017 
# GPL3 (shoutout RMS)
# get youtubehaiku/normaldayinrussia top videos of the day
# open in VLC and autoplay

param (
    [switch]$kurwa = $false
)

$vlcDir = "$env:USERPROFILE\Downloads\vlc"
if ($kurwa) {
    Invoke-WebRequest -Uri http://vlc.tv/r/anormaldayinrussia.xspf -OutFile $vlcdir\memes.xspf
} else {
    Invoke-WebRequest -uri http://vlc.tv/r/youtubehaiku.xspf -OutFile $vlcDir\memes.xspf
}

& 'C:\Program Files\VideoLAN\VLC\vlc.exe' $vlcDir\memes.xspf

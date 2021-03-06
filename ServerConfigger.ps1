﻿Write-host "
Automagic server config-er
# Yabones 2017 
# open sourse asf pls send this to your aunt and grandparents and stuff
"

#declare system setup workflow...
Workflow Configure_System {
    param (
        [string]$hostname,
        [string]$domainName
    )

    Rename-Computer -NewName $hostname -force
    
    # restart computer, then resume on restart...
    Restart-Computer -Wait

    # domain join
    Add-computer -DomainName $domainName -restart -Credential (Get-Credential) 
}


# setup hostname
$hostName = Read-Host "Hostname"
$domainName = Read-host "AD Domain Name"


# Configure networking
do {
    write-output $(Get-netadapter)
    $interfaceAlias = Read-Host "Network Interface"
    $interfaceIP = Read-Host "IP Address"
    $InterfaceSubnet = Read-Host "Bitmask"
    $InterfaceGateway = Read-Host "Gateway"
    $InterfaceDNS = Read-Host "Primary DNS"

    # Make user check input
    Write-Output "`nConfirm:`n`n$interfaceAlias`nIP: $InterfaceIP /$InterfaceSubnet`nGW: $InterfaceGateway`nDNS: $InterfaceDNS"
    pause

    # Apply changes
    New-NetIPAddress -InterfaceAlias $interfaceAlias -IPAddress $interfaceIP -PrefixLength $InterfaceSubnet -DefaultGateway $InterfaceGateway
    Set-DnsClientServerAddress -InterfaceAlias $interfaceAlias -ServerAddresses $InterfaceDNS

    # check changes
    Get-NetIPAddress | Select IPAddress,InterfaceAlias

    if ((Read-Host "Add another IP address? [Y/N]") -eq 'N') {break}

} while ($true) 

# Proceed to call workflow
Configure_System -hostname $hostName -domainname $domainname
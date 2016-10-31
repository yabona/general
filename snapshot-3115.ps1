#C Yabones 2016
#command syntax: snapshot-3115 -FirstName "John" -LastName "Smith" -path 'C:\WinServer' -comment "After Lab #"

param (
    [Parameter(mandatory=$true)][string]$firstname , 
    [Parameter(mandatory=$true)][String]$lastname , 
    [Parameter(mandatory=$true)][String]$path, 
    [String]$comment
)

#known virtual machine names
$machineSuffix = ("C1", "C2", "DC1", "MS1", "WSUS", "ROUTER")

$env:Path += ";C:\Program Files (x86)\VMware\VMware Workstation\"


Set-location $Path


#take the snapshots
foreach ($i in $MachineSuffix) {
    vmrun snapshot .\$lastname-$i\$lastname-$i.vmx $comment
}
vmrun snapshot .\$firstname-DC2\$firstname-DC2.vmx $comment

#if it doesn't go terribly wrong...
write-host "SUCCESS" -ForegroundColor Green
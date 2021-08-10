# sitename for your PureConnect environment
$sitename = ''
# name of the node type from attendant you want to retrieve ('Play Info', 'Subroutine Initiator', etc)
$nodetype = ''

$attpath = "HKLM:\SOFTWARE\WOW6432Node\Interactive Intelligence\EIC\Directory Services\Root\$($sitename)\Production\ITWVOICECICDEVE\AttendantData\Attendant\"

$keys = Get-ChildItem -recurse $attpath | Get-ItemProperty | where { $_.Type -match $nodetype }

foreach ($key in $keys){

	$paths = (($key.FullNodePath -split "Attendant")[-1] -split "\\")
	$paths = $paths[1..$paths.Length]
	
	$basepath = $attpath
	$pathnames = ''
	
	foreach ($path in $paths){
		$basepath = $basepath + $path + "\\"
		$p = Get-Item $basepath | Get-ItemProperty
		$pathnames = $pathnames + $p.Name + " *>* "
		}
	Write-Host($pathnames)
}
	
		


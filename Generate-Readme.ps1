$readmeFile = "{0}\README.md" -f $PSScriptRoot
$readme = @"
# AdiBags_EmeraldDream
Creates an AdiBags filter for items from the Emerald Dream, added in WoW Patch 10.2: Guardians of the Dream.

https://legacy.curseforge.com/wow/addons/adibags-emeralddream

## Emerald Dream Items

{0}
"@

$found = @()
foreach ($line in Get-Content -Path ("{0}\AdiBags_EmeraldDream.lua" -f $PSScriptRoot)) {
	if ($line -match "([0-9]{6}), -- (.+)") {
		$found += "* [{0}](https://wowhead.com/item={1})" -f ($Matches[2], $Matches[1])
	}
}
$found = $found | Sort-Object


if ($found.Count -gt 0) {
	if (Test-Path -Path $readmeFile) {
		Remove-Item -Path $readmeFile -Force
	}
	
	Add-Content -Path $readmeFile -Value ($readme -f (($found -join "`r`n") | Out-String))
}
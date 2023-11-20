$readmeFile = "{0}\README.md" -f $PSScriptRoot
$readme = @"
# AdiBags_EmeraldDream
Creates an AdiBags filter for items from the Emerald Dream, added in WoW Patch 10.2: Guardians of the Dream.

https://legacy.curseforge.com/wow/addons/adibags-emeralddream

## Emerald Dream Items

### Books

{0}

### Cosmetic Items

{1}

### Crafting Items

{2}

### Miscellaneous Items

{3}

### Mounts

{4}

### Pets 

{5}

### Quest Items

{6}

### Reputation Items

{7}

### Toys

{8}

### World Event Items

{9}
"@

$found = @{
	books = @()
	cosmetic = @()
	crafting = @()
	misc = @()
	mounts = @()
	pets = @()
	quest = @()
	reputation = @()
	toys = @()
	worldEvents = @()
}

foreach ($line in Get-Content -Path ("{0}\AdiBags_EmeraldDream.lua" -f $PSScriptRoot)) {
	if ($line -match "([0-9]{6}), -- (.+) \(([a-z]+)\)") {
		$found[$Matches[3]] += "* [{0}](https://www.wowhead.com/item={1})" -f ($Matches[2], $Matches[1])
	}
}


if (Test-Path -Path $readmeFile) {
	Remove-Item -Path $readmeFile -Force
}

$bookStr = ($found.books | Sort-Object) -join "`r`n" | Out-String
$cosmeticStr = ($found.cosmetic | Sort-Object) -join "`r`n" | Out-String
$craftingStr = ($found.crafting | Sort-Object) -join "`r`n" | Out-String
$miscStr = ($found.misc | Sort-Object) -join "`r`n" | Out-String
$mountStr = ($found.mounts | Sort-Object) -join "`r`n" | Out-String
$petStr = ($found.pets | Sort-Object) -join "`r`n" | Out-String
$questStr = ($found.quest | Sort-Object) -join "`r`n" | Out-String
$repStr = ($found.reputation | Sort-Object) -join "`r`n" | Out-String
$toyStr = ($found.toys | Sort-Object) -join "`r`n" | Out-String
$worldEventStr = ($found.worldEvents | Sort-Object) -join "`r`n" | Out-String

$readmeStr = ($readme -f ($bookStr, $cosmeticStr, $craftingStr, $miscStr, $mountStr, $petStr, $questStr, $repStr, $toyStr, $worldEventStr))

Add-Content -Path $readmeFile -Value $readmeStr
Set-Clipboard -Value $readmeStr
-------------------------------------------------------------------------------
-- AdiBags - Emerald Dream By Crackpot (US, Illidan)
-------------------------------------------------------------------------------
local addonName, addon = ...

local L =
	setmetatable(
	{},
	{
		__index = function(self, key)
			if key then
				rawset(self, key, tostring(key))
			end
			return tostring(key)
		end
	}
)
addon.L = L

local locale = GetLocale()

if locale == "deDE" then
	--Translation missing
elseif locale == "enUS" then
    L["Books added in 10.2."] = true
	L["Books"] = true
	L["Cosmetic items added in 10.2."] = true
	L["Cosmetic Items"] = true
	L["Crafting Items"] = true
	L["Emerald Dream"] = true
	L["Items from the Emerald Dream, added in patch 10.2."] = true
	L["Items involved with world events added in 10.2."] = true
	L["Items that give reputation added in 10.2."] = true
	L["Items used in crafting added in 10.2."] = true
	L["Miscellaneous items added in 10.2."] = true
	L["Miscellaneous Items"] = true
	L["Mounts added in 10.2."] = true
	L["Mounts"] = true
	L["Pets added in 10.2."] = true
	L["Pets"] = true
	L["Quest items added in 10.2."] = true
	L["Quest Items"] = true
	L["Reputation Items"] = true
	L["Toys added in 10.2."] = true
	L["Toys"] = true
	L["World Events"] = true
elseif locale == "esES" then
	--Translation missing
elseif locale == "esMX" then
	--Translation missing
elseif locale == "frFR" then
    --Translation missing
elseif locale == "itIT" then
	--Translation missing
elseif locale == "koKR" then
	--Translation missing
elseif locale == "ptBR" then
	--Translation missing
elseif locale == "ruRU" then
	--Translation missing
elseif locale == "zhCN" then
	--Translation missing
elseif locale == "zhTW" then
    --Translation missing
end

-- values by their key
for k, v in pairs(L) do
	if v == true then
		L[k] = k
	end
end

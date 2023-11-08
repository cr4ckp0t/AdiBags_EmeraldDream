-------------------------------------------------------------------------------
-- AdiBags - Emerald Dream By Crackpot (US, Illidan)
-------------------------------------------------------------------------------
local addonName, addon = ...
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

local tonumber = _G.tonumber
local L = addon.L

local dreamFilter = AdiBags:RegisterFilter("Emerald Dream", 98, "ABEvent-1.0")
dreamFilter.uiName = L["Emerald Dream"]
dreamFilter.uiDesc = L["Items from the Emerald Dream, added in patch 10.2."]

function dreamFilter:OnInitialize()
    self.dream = {
        -- From: https://www.wowhead.com/guide/emerald-dream

        [206959] = true, -- Spark of Dreams
        [208047] = true, -- Gigantic Dreamseed
        [208066] = true, -- Small Dreamseed
        [208067] = true, -- Plump Dreamseed
        [208181] = true, -- Shandris's Scouting Report
        [208396] = true, -- Splintered Spark of Dreams
        [208619] = true, -- The Tragedy of Erinethria
        [208649] = true, -- On the Nature of the Dream
        [208837] = true, -- Missing Fruit
        [209947] = true, -- Reins of the Blossoming Dreamstag
        [209949] = true, -- Reins of the Suntouched Dreamstag
        [209950] = true, -- Reins of the Rekindled Dreamstag
        [209951] = true, -- Reins of the Lunar Dreamstag
        [209956] = true, -- Ori's Verdant Feather
        [209957] = true, -- Fang of the Frenzied Nightclaw
        [210050] = true, -- Mysterious Seeds
        [210059] = true, -- Reins of the Winter Night Dreamsaber
        [210180] = true, -- Emerald Flightstone
        [210208] = true, -- Plump Dreamy Bounty
        [210217] = true, -- Small Dreamy Bounty
        [210218] = true, -- Plump Dreamy Bounty
        [210219] = true, -- Gigantic Dreamy Bounty
        [210224] = true, -- Small Emerald Bloom
        [210225] = true, -- Medium Emerald Bloom
        [210226] = true, -- Large Emerald Bloom
        [210237] = true, -- Nipping Night's Necklace
        [210346] = true, -- Self-Baking Herb Based Cookies
        [210411] = true, -- Fast Growing Seed
        [210412] = true, -- Flourishing Whimsydrake
        [210414] = true, -- Forest Lord's Antlers
        [210434] = true, -- Visage of Ursol
        [210505] = true, -- Reverie
        [210553] = true, -- Dreamborne Scarab
        [210555] = true, -- Dreamhoof
        [210567] = true, -- Memorie
        [210631] = true, -- Branch of Ashamane
        [210647] = true, -- Mark of the Umbramane
        [210650] = true, -- Mark of the Keen-Eyed Dreamsaber
        [210652] = true, -- Somnolet
        [210659] = true, -- Branch of Aviana
        [210660] = true, -- Claw of Lo'Gosh
        [210683] = true, -- Mark of the Dreamtalon Matriarch
        [210725] = true, -- Owl Post
        [210730] = true, -- Mark of the Dream Wardens
        [210757] = true, -- Scales of Remorse
        [210769] = true, -- Reins of the Springtide Dreamtalon
        [210774] = true, -- Reins of the Ochre Dreamtalon
        [210775] = true, -- Reins of the Snowfluff Dreamtalon
        [210776] = true, -- Lesser Dream Infusion
        [210777] = true, -- Drowsey
        [210785] = true, -- Snorr
        [210831] = true, -- Delugen
        [210833] = true, -- Talont
        [210872] = true, -- Satchel of Dreams
        [210917] = true, -- Pouch of Whelpling's Dreaming Crests
        [210945] = true, -- Stargrazer
        [210946] = true, -- Mammyth
        [210948] = true, -- Imagiwing
        [210969] = true, -- Salatrancer
        [211376] = true, -- Seedbloom
        [211389] = true, -- Cache of Overblooming Treasures
        [211410] = true, -- Bloomed Wildling Cache
        [211411] = true, -- Sprouting Dreamtrove
        [211413] = true, -- Budding Dreamtrove
        [211414] = true, -- Blossoming Dreamtrove
        [211417] = true, -- Dream Wardens Insignia
        [211495] = true, -- Dreambound Augment Rune
    }
end

function dreamFilter:Update()
    self:SendMessage("AdiBags_FiltersChanged")
end

function dreamFilter:OnEnable()
    AdiBags:UpdateFilters()
end

function dreamFilter:OnDisable()
    AdiBags:UpdateFilters()
end

function dreamFilter:Filter(slotData)
    if self.dream[tonumber(slotData.itemId)] then
        return L["Emerald Dream"]
    end
end
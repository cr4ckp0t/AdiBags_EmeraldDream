-------------------------------------------------------------------------------
-- AdiBags - Emerald Dream By Crackpot (US, Illidan)
-------------------------------------------------------------------------------
local addonName, addon = ...
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

local tonumber = _G.tonumber
local L = addon.L

local filterItems

local books = {
    208619, -- The Tragedy of Erinethria
    208649, -- On the Nature of the Dream
    210049, -- The Legend of Elun'Ahir
    210346, -- Self-Baking Herb Based Cookies
    210737, -- Ashwood Research Binder
}

local cosmetic = {
    210414, -- Forest Lord's Antlers
    210434, -- Visage of Ursol
    210631, -- Branch of Ashamane
    210659, -- Branch of Aviana
    210660, -- Claw of Lo'Gosh
    210678, -- Verdant Gleaner's Scythe
    210676, -- Elderwood Cane
    210677, -- Survivalist's Shovel
    210679, -- Cultivator's Watering Can
    210680, -- Caretaker's Trowel
    210685, -- Ranger's Longbow
    210790, -- Ensemble: Elegant Green Dragon Outerwear
    210996, -- Moonberry's Many Mischief Makers
}

local crafting = {
    206959, -- Spark of Dreams
    208396, -- Splintered Spark of Dreams
    209837, -- Faint Whispers of Dreaming
    210180, -- Emerald Flightstone
    210917, -- Pouch of Whelpling's Dreaming Crests
}

local miscellaneous = {
    210647, -- Mark of the Umbramane
    210650, -- Mark of the Keen-Eyed Dreamsaber
    210683, -- Mark of the Dreamtalon Matriarch
    210872, -- Satchel of Dreams
    211303, -- Dryad's Supply Pouch
    211376, -- Seedbloom
    211495, -- Dreambound Augment Rune
}

local mounts = {
    209947, -- Reins of the Blossoming Dreamstag
    209949, -- Reins of the Suntouched Dreamstag
    209950, -- Reins of the Rekindled Dreamstag
    209951, -- Reins of the Lunar Dreamstag
    210057, -- Reins of the Morning Flourish Dreamsaber
    210058, -- Reins of the Evening Sun Dreamsaber
    210059, -- Reins of the Winter Night Dreamsaber
    210412, -- Flourishing Whimsydrake
    210769, -- Reins of the Springtide Dreamtalon
    210774, -- Reins of the Ochre Dreamtalon
    210775, -- Reins of the Snowfluff Dreamtalon
    210831, -- Delugen
    210833, -- Talont
    210945, -- Stargrazer
    210946, -- Mammyth
    210948, -- Imagiwing
    210969, -- Salatrancer
}

local pets = {
    210505, -- Reverie
    210553, -- Dreamborne Scarab
    210555, -- Dreamhoof
    210567, -- Memorie
    210570, -- Napps
    210571, -- Snoozles
    210648, -- Seedle
    210651, -- Dustite
    210652, -- Somnolet
    210689, -- Snoots
    210690, -- Elmer
    210691, -- Spruce
    210692, -- Juniper
    210776, -- Lesser Dream Infusion
    210777, -- Drowsey
    210785, -- Snorr
}

local quest = {
    208181, -- Shandris's Scouting Report
    208837, -- Missing Fruit
    210050, -- Mysterious Seeds
    211373, -- Bag of Many Wonders
    211410, -- Bloomed Wildling Cache
}

local reputation = {
    210730, -- Mark of the Dream Wardens
    210757, -- Scales of Remorse
    210951, -- Treacherous Research Notes
    210952, -- Spare Heated Hearthstone
    210954, -- Sprout of Rebirth
    210957, -- Rune of the Fire Druids
    210958, -- Crown of the Dryad Daughter
    211366, -- Drops of Moon Water
    211369, -- Charred Staff of the Overseer
    211370, -- Branch of Gracus
    211371, -- Dryad-Keeper Credentials
    211374, -- Tangled Yarn of Secrets
    211417, -- Dream Wardens Insignia
}

local toys = {
    210411, -- Fast Growing Seed
    210725, -- Owl Post
    210997, -- Spare Party Hat
}

local worldEvents = {
    208047, -- Gigantic Dreamseed
    208066, -- Small Dreamseed
    208067, -- Plump Dreamseed
    210217, -- Small Dreamy Bounty
    210218, -- Plump Dreamy Bounty
    210219, -- Gigantic Dreamy Bounty
    210224, -- Small Emerald Bloom
    210225, -- Medium Emerald Bloom
    210226, -- Large Emerald Bloom
    211389, -- Cache of Overblooming Treasures
    211411, -- Sprouting Dreamtrove
    211413, -- Budding Dreamtrove
    211414, -- Blossoming Dreamtrove
}

local function addToFilter(set, list)
    for _, v in ipairs(list) do
        set[v] = true
    end
end

local function filterItemsInit(self)
    local items = {}

    -- build the filter list
    if self.db.profile.filterBooks then addToFilter(items, books) end
    if self.db.profile.filterCosmetic then addToFilter(items, cosmetic) end
    if self.db.profile.filterCrafting then addToFilter(items, crafting) end
    if self.db.profile.filterMisc then addToFilter(items, miscellaneous) end
    if self.db.profile.filterMounts then addToFilter(items, mounts) end
    if self.db.profile.filterQuest then addToFilter(items, quest) end
    if self.db.profile.filterPets then addToFilter(items, pets) end
    if self.db.profile.filterReputation then addToFilter(items, reputation) end
    if self.db.profile.filterToys then addToFilter(items, toys) end
    if self.db.profile.filterWorldEvents then addToFilter(items, worldEvents) end

    return items
end

local dreamFilter = AdiBags:RegisterFilter("Emerald Dream", 98, "ABEvent-1.0")
dreamFilter.uiName = L["Emerald Dream"]
dreamFilter.uiDesc = L["Items from the Emerald Dream, added in patch 10.2."]

function dreamFilter:OnInitialize()
    self.db = AdiBags.db:RegisterNamespace("Emerald Dream", {
        profile = {
            filterBooks = true,
            filterCosmetic = true,
            filterCrafting = true,
            filterMisc = true,
            filterMounts = true,
            filterQuest = true,
            filterPets = true,
            filterReputation = true,
            filterToys = true,
            filterWorldEvents= true,
        }
    })
end

function dreamFilter:Update()
    filterItems = nil
    self:SendMessage("AdiBags_FiltersChanged")
end

function dreamFilter:OnEnable()
    AdiBags:UpdateFilters()
end

function dreamFilter:OnDisable()
    AdiBags:UpdateFilters()
end

function dreamFilter:Filter(slotData)
    filterItems = filterItems or filterItemsInit(self)
    if filterItems[tonumber(slotData.itemId)] then
        return L["Emerald Dream"]
    end
end

function dreamFilter:GetOptions()
    return {
        filterBooks = {
            name = L["Books"],
            desc = L["Books added in 10.2."],
            type = "toggle",
            order = 10,
        },
        filterCosmetic = {
            name = L["Cosmetic Items"],
            desc = L["Cosmetic items added in 10.2."],
            type = "toggle",
            order = 20,
        },
        filterCrafting = {
            name = L["Crafting Items"],
            desc = L["Items used in crafting added in 10.2."],
            type = "toggle",
            order = 30,
        },
        filterMisc = {
            name = L["Miscellaneous Items"],
            desc = L["Miscellaneous items added in 10.2."],
            type = "toggle",
            order = 40,
        },
        filterMounts = {
            name = L["Mounts"],
            desc = L["Mounts added in 10.2."],
            type = "toggle",
            order = 50,
        },
        filterQuest = {
            name = L["Quest Items"],
            desc = L["Quest items added in 10.2."],
            type = "toggle",
            order = 60,
        },
        filterPets = {
            name = L["Pets"],
            desc = L["Pets added in 10.2."],
            type = "toggle",
            order = 70,
        },
        filterReputation = {
            name = L["Reputation Items"],
            desc = L["Items that give reputation added in 10.2."],
            type = "toggle",
            order = 80,
        },
        filterToys = {
            name = L["Toys"],
            desc = L["Toys added in 10.2."],
            type = "toggle",
            order = 90,
        },
        filterWorldEvents = {
            name = L["World Events"],
            desc = L["Items involved with world events added in 10.2."],
            type = "toggle",
            order = 100
        },
    },
    AdiBags:GetOptionHandler(self, false, function() return self:Update() end)
end
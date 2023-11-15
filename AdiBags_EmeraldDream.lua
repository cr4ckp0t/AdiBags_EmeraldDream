-------------------------------------------------------------------------------
-- AdiBags - Emerald Dream By Crackpot (US, Illidan)
-------------------------------------------------------------------------------
local addonName, addon = ...
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

local tonumber = _G.tonumber
local L = addon.L

local filterItems

local books = {
    -- Books
    208619, -- The Tragedy of Erinethria (books)
    208649, -- On the Nature of the Dream (books)
    210049, -- The Legend of Elun'Ahir (books)
    210346, -- Self-Baking Herb Based Cookies (books)
    210737, -- Ashwood Research Binder (books)
}

local cosmetic = {
    210414, -- Forest Lord's Antlers (cosmetic)
    210434, -- Visage of Ursol (cosmetic)
    210631, -- Branch of Ashamane (cosmetic)
    210659, -- Branch of Aviana (cosmetic)
    210660, -- Claw of Lo'Gosh (cosmetic)
    210678, -- Verdant Gleaner's Scythe (cosmetic)
    210676, -- Elderwood Cane (cosmetic)
    210677, -- Survivalist's Shovel (cosmetic)
    210679, -- Cultivator's Watering Can (cosmetic)
    210680, -- Caretaker's Trowel (cosmetic)
    210685, -- Ranger's Longbow (cosmetic)
    210790, -- Ensemble: Elegant Green Dragon Outerwear (cosmetic)
    210996, -- Moonberry's Many Mischief Makers (cosmetic)
}

local crafting = {
    206959, -- Spark of Dreams (crafting)
    208396, -- Splintered Spark of Dreams (crafting)
    209837, -- Faint Whispers of Dreaming (crafting)
    210180, -- Emerald Flightstone (crafting)
    210917, -- Pouch of Whelpling's Dreaming Crests (crafting)
}

local miscellaneous = {
    210647, -- Mark of the Umbramane (misc)
    210650, -- Mark of the Keen-Eyed Dreamsaber (misc)
    210683, -- Mark of the Dreamtalon Matriarch (misc)
    210872, -- Satchel of Dreams (misc)
    211303, -- Dryad's Supply Pouch (misc)
    211376, -- Seedbloom (misc)
    211495, -- Dreambound Augment Rune (misc)
}

local mounts = {
    209947, -- Reins of the Blossoming Dreamstag (mounts)
    209949, -- Reins of the Suntouched Dreamstag (mounts)
    209950, -- Reins of the Rekindled Dreamstag (mounts)
    209951, -- Reins of the Lunar Dreamstag (mounts)
    210057, -- Reins of the Morning Flourish Dreamsaber (mounts)
    210058, -- Reins of the Evening Sun Dreamsaber (mounts)
    210059, -- Reins of the Winter Night Dreamsaber (mounts)
    210412, -- Flourishing Whimsydrake (mounts)
    210769, -- Reins of the Springtide Dreamtalon (mounts)
    210774, -- Reins of the Ochre Dreamtalon (mounts)
    210775, -- Reins of the Snowfluff Dreamtalon (mounts)
    210831, -- Delugen (mounts)
    210833, -- Talont (mounts)
    210945, -- Stargrazer (mounts)
    210946, -- Mammyth (mounts)
    210948, -- Imagiwing (mounts)
    210969, -- Salatrancer (mounts)
}

local pets = {
    210505, -- Reverie (pets)
    210553, -- Dreamborne Scarab (pets)
    210555, -- Dreamhoof (pets)
    210567, -- Memorie (pets)
    210570, -- Napps (pets)
    210571, -- Snoozles (pets)
    210648, -- Seedle (pets)
    210651, -- Dustite (pets)
    210652, -- Somnolet (pets)
    210689, -- Snoots (pets)
    210690, -- Elmer (pets)
    210691, -- Spruce (pets)
    210692, -- Juniper (pets)
    210776, -- Lesser Dream Infusion (pets)
    210777, -- Drowsey (pets)
    210785, -- Snorr (pets)
}

local quest = {
    208181, -- Shandris's Scouting Report (quest)
    208837, -- Missing Fruit (quest)
    210050, -- Mysterious Seeds (quest)
    211373, -- Bag of Many Wonders (quest)
    211410, -- Bloomed Wildling Cache (quest)
}

local reputation = {
    210730, -- Mark of the Dream Wardens (reputation)
    210757, -- Scales of Remorse (reputation)
    210916, -- Ember of Fyrakk
    210951, -- Treacherous Research Notes (reputation)
    210952, -- Spare Heated Hearthstone (reputation)
    210954, -- Sprout of Rebirth (reputation)
    210957, -- Rune of the Fire Druids (reputation)
    210958, -- Crown of the Dryad Daughter (reputation)
    211366, -- Drops of Moon Water (reputation)
    211369, -- Charred Staff of the Overseer (reputation)
    211370, -- Branch of Gracus (reputation)
    211371, -- Dryad-Keeper Credentials (reputation)
    211374, -- Tangled Yarn of Secrets (reputation)
    211417, -- Dream Wardens Insignia (reputation)
}

local toys = {
    210411, -- Fast Growing Seed (toys)
    210725, -- Owl Post (toys)
    210997, -- Spare Party Hat (toys)
}

local worldEvents = {
    208047, -- Gigantic Dreamseed (worldEvents)
    208066, -- Small Dreamseed (worldEvents)
    208067, -- Plump Dreamseed (worldEvents)
    210217, -- Small Dreamy Bounty (worldEvents)
    210218, -- Plump Dreamy Bounty (worldEvents)
    210219, -- Gigantic Dreamy Bounty (worldEvents)
    210224, -- Small Emerald Bloom (worldEvents)
    210225, -- Medium Emerald Bloom (worldEvents)
    210226, -- Large Emerald Bloom (worldEvents)
    211389, -- Cache of Overblooming Treasures (worldEvents)
    211411, -- Sprouting Dreamtrove (worldEvents)
    211413, -- Budding Dreamtrove (worldEvents)
    211414, -- Blossoming Dreamtrove (worldEvents)
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
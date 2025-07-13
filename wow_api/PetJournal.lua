_G.C_PetJournal = {}
local C_PetJournal = _G.C_PetJournal

local path = debug.getinfo(1, "S").short_src:match("(.*[/\\])") or "./"

loadfile(path .. 'test_data/PetInfo.lua')()
loadfile(path .. 'test_data/PetStats.lua')()

LE_PET_JOURNAL_FILTER_COLLECTED = 1
LE_PET_JOURNAL_FILTER_NOT_COLLECTED = 2

BATTLE_PET_BREED_QUALITY1 = "Poor"
BATTLE_PET_BREED_QUALITY2 = "Common"
BATTLE_PET_BREED_QUALITY3 = "Uncommon"
BATTLE_PET_BREED_QUALITY4 = "Rare"
BATTLE_PET_BREED_QUALITY5 = "Epic"
BATTLE_PET_BREED_QUALITY6 = "Legendary"

function C_PetJournal.GetNumPets()
    return 561, 43
end

function C_PetJournal.GetPetInfoByIndex(index)
    local pet = _G.PetInfo[index]
    local petID = pet['petID']
    local speciesID = pet['speciesID']
    local owned = pet['owned']
    local customName = pet['customName']
    local level = pet['level']
    local favorite = pet['favorite']
    local isRevoked = pet['isRevoked']
    local speciesName = pet['speciesName']
    local icon = pet['icon']
    local petType = pet['petType']
    local companionID = pet['companionID']
    local tooltip = pet['tooltip']
    local description = pet['description']
    local isWild = pet['isWild']
    local canBattle = pet['canBattle']
    local isTradeable = pet['isTradeable']
    local isUnique = pet['isUnique']
    local obtainable = pet['obtainable']

    return petID, speciesID, owned, customName, level, favorite, isRevoked, speciesName, icon, petType, companionID, tooltip, description, isWild, canBattle, isTradeable, isUnique, obtainable
end

function C_PetJournal.GetPetInfoByPetID(petID)
    for _, pet in ipairs(_G.PetInfo) do
        if pet['petID'] == petID then
            return pet['speciesID'],
            pet['customName'],
            pet['level'],
            pet['xp'],
            pet['maxXp'],
            pet['displayID'],
            pet['isFavorite'],
            pet['speciesName'],
            pet['icon'],
            pet['petType'],
            pet['creatureID'],
            pet['sourceText'],
            pet['description'], pet['isWild'], pet['canBattle'], pet['isTradeable'], pet['isUnique'], pet['obtainable']
        end
    end
    error(('No pet with ID %s'):format(petID))
end

function C_PetJournal.GetPetStats(petID)
    local pet = PetStats[petID]
    return pet['health'], pet['maxHealth'], pet['power'], pet['speed'], pet['rarity']
end

function C_PetJournal.IsFilterChecked(filter)
    return true
end

function C_PetJournal.IsPetTypeChecked(index)
    return true
end

function C_PetJournal.IsPetSourceChecked(index)
    return true
end

function C_PetJournal.ClearSearchFilter()

end

function C_PetJournal.GetNumPetTypes()
    return 10
end

function C_PetJournal.GetNumPetSources()
    return 12
end
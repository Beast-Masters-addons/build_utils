function _G.save_pet_data()
    local total = _G.C_PetJournal.GetNumPets()
    _G.PetInfo = {}
    _G.PetStats = {}
    for i = 1, total do
        local petID, speciesID, owned, customName, level, favorite, isRevoked, speciesName, icon, petType, companionID, tooltip, description, isWild, canBattle, isTradeable, isUnique, obtainable = C_PetJournal.GetPetInfoByIndex(i)
        table.insert(_G.PetInfo, {
            petID = petID,
            speciesID = speciesID,
            owned = owned,
            customName = customName,
            level = level,
            favorite = favorite,
            isRevoked = isRevoked,
            speciesName = speciesName,
            icon = icon,
            petType = petType,
            companionID = companionID,
            tooltip = tooltip,
            description = description,
            isWild = isWild,
            canBattle = canBattle,
            isTradeable = isTradeable,
            isUnique = isUnique,
            obtainable = obtainable
        })

        if petID then
            local health, maxHealth, power, speed, rarity = _G.C_PetJournal.GetPetStats(petID)
            _G.PetStats[petID] = {
                health = health,
                maxHealth = maxHealth,
                power = power,
                speed = speed,
                rarity = rarity
            }
        end
    end
end
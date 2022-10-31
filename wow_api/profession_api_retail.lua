_G.C_TradeSkillUI = {}

function _G.C_TradeSkillUI.IsTradeSkillReady()
    return true
end

function _G.C_TradeSkillUI.IsDataSourceChanging()
    return false
end

function _G.C_TradeSkillUI.GetTradeSkillLine()
    local skillLineName = 'Alchemy'
    local skillLineRank = 10
    local skillLineMaxRank = 125

    return 171, skillLineName, skillLineRank, skillLineMaxRank
end

function _G.C_TradeSkillUI.GetRecipeNumReagents(recipeID)
    if recipeID == 3447 then
        return 3
    end
end

function _G.C_TradeSkillUI.GetRecipeReagentItemLink(skillId, reagentId)
    if skillId == 2 or 3447 then
        if reagentId == 1 then
            return '\124cffffffff\124Hitem:2453::::::::60:::::\124h[Bruiseweed]\124h\124r'
        elseif reagentId == 2 then
            return '\124cffffffff\124Hitem:2450::::::::60:::::\124h[Briarthorn]\124h\124r'
        elseif reagentId == 3 then
            return '\124cffffffff\124Hitem:3372::::::::60:::::\124h[Leaded Vial]\124h\124r;'
        end
    else
        error('Invalid skillId ' .. skillId)
    end
end

function _G.C_TradeSkillUI.GetRecipeItemLink(recipeID)
    if recipeID == 2 or 3447 then
        return '\124cffffffff\124Hitem:929::::::::60:::::\124h[Healing Potion]\124h\124r'
    else
        error('Invalid recipeID ' .. recipeID)
    end
end

function _G.C_TradeSkillUI.GetRecipeReagentInfo(tradeSkillRecipeId, reagentId)
    if tradeSkillRecipeId == 3447 and reagentId == 1 then
        local reagentName = 'Bruiseweed'
        local reagentTexture = 'inv_misc_herb_01'
        local reagentCount = 1
        local playerReagentCount = 20

        return reagentName, reagentTexture, reagentCount, playerReagentCount
    end
end

function _G.C_TradeSkillUI.GetAllRecipeIDs()
    return { 3447 }
end

function _G.C_TradeSkillUI.GetRecipeInfo(recipeID)
    if recipeID == 3447 then
        return {
            ['name'] = 'Healing Potion',
            ['link'] = '\124cffffffff\124Hitem:929::::::::60:::::\124h[Healing Potion]\124h\124r',
            ['learned'] = true,
            ['numAvailable'] = 10,
            ['difficulty'] = 'optimal'
        }
    else
        error('Invalid recipeId ' .. recipeID)
    end
end

function C_TradeSkillUI.GetCategoryInfo(categoryID)
    return nil
end

function C_TradeSkillUI.GetProfessionInfoBySkillLineID(index)
    return {
        ['skillLevel'] = 0,
        ['professionID'] = 0,
        ['skillModifier'] = 0,
        ['isPrimaryProfession'] = false,
        ['professionName'] = "",
        ['maxSkillLevel'] = 0,
        ['expansionName'] = ""
    }
end

---Returns spell tab indices of the player's current professions
function _G.GetProfessions()
    return 6, 9, 10, 8, 7
end

function _G.GetProfessionInfo(index)
    if index == 6 then
        return 'Leatherworking', 136247, 65, 100, 1, 120, 165, 0, 10, 0, 'Legion Leatherworking'
    else
        return 'test'
    end
end
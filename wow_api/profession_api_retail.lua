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

function _G.C_TradeSkillUI.GetProfessionChildSkillLineID()
    return 2485
end

function _G.C_TradeSkillUI.GetProfessionInfoBySkillLineID()
    return {
        ['skillLevel'] = 10,
        ['professionID'] = 2485,
        ['skillModifier'] = 0,
        ['parentProfessionName'] = "Alchemy",
        ['parentProfessionID'] = 171,
        ['profession'] = 3,
        ['isPrimaryProfession'] = true,
        ['professionName'] = "Classic Alchemy",
        ['maxSkillLevel'] = 125,
        ['expansionName'] = "Classic"
    }
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

function _G.C_TradeSkillUI.GetRecipeSchematic(recipeSpellID, isRecraft, recipeLevel)

    return {
        ["outputItemID"] = 44838,
        ["hasCraftingOperationInfo"] = false,
        ["quantityMax"] = 1,
        ["quantityMin"] = 1,
        ["recipeID"] = 62045,
        ["recipeType"] = 1,
        ["name"] = "Slow-Roasted Turkey",
        ["reagentSlotSchematics"] = {
            {
                ["quantityRequired"] = 1,
                ["dataSlotIndex"] = 1,
                ["slotIndex"] = 1,
                ["dataSlotType"] = 1,
                ["reagentType"] = 1,
                ["orderSource"] = 0,
                ["reagents"] = {
                    {
                        ["itemID"] = 44834,
                    },
                },
            },
            {
                ["quantityRequired"] = 2,
                ["dataSlotIndex"] = 2,
                ["slotIndex"] = 2,
                ["dataSlotType"] = 1,
                ["reagentType"] = 1,
                ["orderSource"] = 0,
                ["reagents"] = {
                    {
                        ["itemID"] = 44853,
                    },
                },
            },
            {
                ["quantityRequired"] = 1,
                ["dataSlotIndex"] = 3,
                ["slotIndex"] = 3,
                ["dataSlotType"] = 1,
                ["reagentType"] = 1,
                ["orderSource"] = 0,
                ["reagents"] = {
                    {
                        ["itemID"] = 44835,
                    },
                },
            },
        },
        ["isRecraft"] = false,
        ["icon"] = 0,
    }
end

function _G.C_TradeSkillUI.GetRecipeFixedReagentItemLink(recipeID, reagentIndex)
    local links = {
        "\124cffffffff\124Hitem:2453::::::::60:::::\124h[Bruiseweed]\124h\124r",
        "\124cffffffff\124Hitem:2450::::::::70:::::\124h[Briarthorn]\124h\124r",
        "\124cffffffff\124Hitem:3371::::::::70:::::\124h[Crystal Vial]\124h\124r",
    }
    return links[reagentIndex]
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
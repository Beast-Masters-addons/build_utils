--- Returns the item ID for an equipped item.
--- [https://wowpedia.fandom.com/wiki/API_GetInventoryItemID]
--- @param unit string @  : UnitId - The unit whose inventory is to be queried.
--- @param invSlotId number @  : InventorySlotId - to be queried, obtained via GetInventorySlotInfo.
--- @return number, number @ itemId, unknown
function GetInventoryItemID(unit, invSlotId)
    if unit == 'player' and invSlotId == 1 then
        return 9859
    end
end

--- Returns the item link for an equipped item.
--- [https://wowpedia.fandom.com/wiki/API_GetInventoryItemLink]
--- @param unit string @  : UnitId - The unit whose inventory is to be queried.
--- @param invSlotId number @  : InventorySlotId - The inventory slot to be queried.
--- @return string @ itemLink
function GetInventoryItemLink(unit, invSlotId)
    if unit == 'player' and invSlotId == 1 then
        return "|cff1eff00|Hitem:9859::::::::80:::::|h[Archer's Cap]|h|r";
    end
end

--- Returns the quality of an equipped item.
--- [https://wowpedia.fandom.com/wiki/API_GetInventoryItemQuality]
--- @param unitId string @  : UnitId - The unit whose inventory is to be queried.
--- @param invSlotId number @  : InventorySlotId - The slot ID to be queried, obtained via GetInventorySlotInfo().
--- @return unknown @ quality
function GetInventoryItemQuality(unitId, invSlotId)
end

--- Returns the texture for an equipped item.
--- [https://wowpedia.fandom.com/wiki/API_GetInventoryItemTexture]
--- @param unit string @  : UnitId
--- @param invSlotId number @  : InventorySlotId
--- @return number @ texture
function GetInventoryItemTexture(unit, invSlotId)
    if unit == 'player' and invSlotId == 1 then
        return 133117
    end
end
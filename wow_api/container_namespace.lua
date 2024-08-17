_G.C_Container = {}

function _G.C_Container.GetContainerNumFreeSlots(slot)
    return 10
end

function _G.C_Container.GetContainerNumSlots(slot)
    return 30
end

function _G.C_Container.GetContainerItemInfo(containerIndex, slotIndex)
    if containerIndex == 1 and slotIndex == 1 then
        return {
            hasLoot = false,
            hyperlink = "|cffffffff|Hitem:6948::::::::49:253:::::|h[Hearthstone]|h|r",
            iconFileID = 134414,
            hasNoValue = true,
            isLocked = false,
            itemID = 6948,
            isBound = true,
            stackCount = 1,
            isFiltered = false,
            isReadable = false,
            quality = 1,
        }
    end
end

function _G.C_Container.PickupContainerItem(containerIndex, slotIndex)
    return 6948
end
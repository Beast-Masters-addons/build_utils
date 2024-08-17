function GetContainerNumFreeSlots(slot)
    return 10
end

function GetContainerNumSlots(slot)
    return 30
end

function GetContainerItemInfo(containerIndex, slotIndex)
    if containerIndex == 1 and slotIndex == 1 then
        return
        134414, --icon
        1, --itemCount
        false, --locked
        1, --quality
        false, --readable
        false, --lootable
        "|cffffffff|Hitem:6948::::::::42:::::|h[Hearthstone]|h|r", --itemLink
        false, --isFiltered
        true, --noValue
        6948, --itemId
        true --isBound
    end
end

function PickupContainerItem(containerIndex, slotIndex)
    return 6948
end
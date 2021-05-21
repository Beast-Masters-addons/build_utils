--loadfile('MapInfo.lua')()
--loadfile('AreaInfo.lua')()

_G.C_Map = {}
function _G.C_Map.GetAreaInfo(areaID)
    if areaID == 1 then
        return 'Dun Morogh'
    elseif areaID == 33 then
        return 'Stranglethorn Vale'
    end
end

function _G.C_Map.GetBestMapForUnit(unit)
    if unit == 'player' then
        return 1434
    end
end
function _G.C_Map.GetMapChildrenInfo(uiMapID, mapType, allDescendants)
    local children = {}
    for id, map in pairs(_G['MapInfo']) do
        if map['ParentMapID'] == uiMapID then
            if mapType == nil or mapType == map['MapType'] then
                table.insert(children, {
                    mapType = map['MapType'],
                    mapID = id,
                    name = map['MapName_lang'],
                    parentMapID = uiMapID,
                })
            end
        end
    end
    return children
end

function _G.C_Map.GetMapInfo(uiMapID)
    local info = _G['AreaInfo'][uiMapID]
    local map = _G['MapInfo'][uiMapID]
    if map == nil then
        if info ~= nil then
            return { mapID = uiMapID,
                     name = info['AreaName_lang'],
            }
        end

        --print(('Unknown mapId %d'):format(uiMapID))
        return
    end
    return { mapID = uiMapID,
             name = map['MapName_lang'],
             mapType = map['MapType'],
             parentMapID = map['ParentMapID'],
             flags = map['Flags[0]']
    }
end

function _G.C_Map.GetMapArtID(uiMapID)

end

function C_Map.GetWorldPosFromMapPos(uiMapID, mapPosition)

end

function C_Map.GetPlayerMapPosition(uiMapID, unitToken)

end

function _G.GetLocale()
    return _G['locale'] or 'enUS'
end

function _G.UnitLevel(unit)
    if unit == 'player' then
        return _G['playerLevel'] or 34
    end
end

function GetRealZoneText(uiMapID)
    local map = _G.C_Map.GetMapInfo(uiMapID)
    if map then
        return map['name']
    end
end

function GetPlayerWorldPosition()

end

_G.Enum = {
    UIMapType = {
        Cosmic = 0,
        World = 1,
        Continent = 2,
        Zone = 3,
        Dungeon = 4,
        Micro = 5,
        Orphan = 6,
    }
}

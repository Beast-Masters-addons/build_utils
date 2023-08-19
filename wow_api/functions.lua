_G['SlashCmdList'] = {}

function GetBuildInfo()
    if os.getenv('GAME_VERSION') == 'classic' then
        return "1.13.2", 32600, "Nov 20 2019", 11302
    elseif os.getenv('GAME_VERSION') == 'bcc' then
        return "2.5.1", 38364, "Apr 15 2021", 20501
    elseif os.getenv('GAME_VERSION') == 'wrath' then
        return "3.4.0", 45327, "Aug 25 2022", 30400
    else
        return "9.0.1", "36492", "Oct 30 2020", 90001
    end
end

function UnitFactionGroup(unit)
    return _G['UnitFaction'] or 'Alliance'
end

function hooksecurefunc(func)

end

function InterfaceOptions_AddCategory()

end

DEFAULT_CHAT_FRAME = {}
function DEFAULT_CHAT_FRAME:AddMessage(str, r, g, b)
    return str, r, g, b
end

function wipe()
end

function IsLoggedIn()
    return false
end

C_ChromieTime = {}
function C_ChromieTime.GetChromieTimeExpansionOptions()
    return { { alreadyOn = false } }
end

function DevTools_Dump(value)
    require 'pl.pretty'.dump(value)
end

C_UIColor = {}
function C_UIColor.GetColors()
    return {} --TODO: Get table https://wow.tools/dbc/?dbc=globalcolor&build=10.0.2.46702#page=1
end

function GetAddOnInfo(addon)
    return addon, addon
end

function UnitRace(unit)
    if unit == "player" then
        return "Night Elf", "NightElf", 4
    end
end

---@return string className, classFilename, classID
function UnitClass(unit)
    if unit == "player" then
        return "Hunter", "HUNTER", 3
    end
end

function UnitSex(unit)
    if unit == "player" then
        return 3
    end
end

function UnitName(unit)
    if unit == "player" then
        return "Quadduo"
    end
end

function GetRealmName()
    return "Mirage Raceway"
end

function GetSpellInfo(spellId)
    if spellId == 186257 then
        return "Aspect of the Cheetah", 132242, 0, 0, 0, 186257
    end
end

function CastSpellByName(spellName)
    return spellName
end

function GetMoney()
    return 62993
end

function GetCursorMoney()
    return 0
end

function GetPlayerTradeMoney()
    return 0
end

function GetGuildInfo(unit)
    if unit == "player" then
        return "The Wasnots", "member", 4
    end
end

function GetLocale()
    return _G['locale'] or 'enUS'
end

function GetCurrentRegion()
    return 3
end

function UnitLevel(unit)
    if unit == 'player' then
        return _G['playerLevel'] or 34
    end
end
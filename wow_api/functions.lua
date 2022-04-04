_G['SlashCmdList'] = {}

function GetBuildInfo()
    if os.getenv('GAME_VERSION') == 'classic' then
        return "1.13.2", 32600, "Nov 20 2019", 11302
    elseif os.getenv('GAME_VERSION') == 'bcc' then
        return "2.5.1", 38364, "Apr 15 2021", 20501
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
    print(str)
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
EXPANSION_NAME0 = "Classic"
EXPANSION_NAME1 = "The Burning Crusade"
EXPANSION_NAME2 = "Wrath of the Lich King"
EXPANSION_NAME3 = "Cataclysm"
EXPANSION_NAME4 = "Mists of Pandaria"
EXPANSION_NAME5 = "Warlords of Draenor"
EXPANSION_NAME6 = "Legion"
EXPANSION_NAME7 = "Battle for Azeroth"
EXPANSION_NAME8 = "Shadowlands"
EXPANSION_NAME9 = "Dragonflight"

ZONE = "Zone"

--https://warcraft.wiki.gg/wiki/WOW_PROJECT_ID
_G.WOW_PROJECT_MAINLINE = 1
_G.WOW_PROJECT_CLASSIC = 2
_G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC = 5
_G.WOW_PROJECT_WRATH_CLASSIC = 11
_G.WOW_PROJECT_CATACLYSM_CLASSIC = 14

if os.getenv('GAME_VERSION') == 'classic' then
    _G.WOW_PROJECT_ID = _G.WOW_PROJECT_CLASSIC
elseif os.getenv('GAME_VERSION') == 'bcc' then
    _G.WOW_PROJECT_ID = _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC
elseif os.getenv('GAME_VERSION') == 'wrath' then
    _G.WOW_PROJECT_ID = _G.WOW_PROJECT_WRATH_CLASSIC
elseif os.getenv('GAME_VERSION') == 'cata' then
    _G.WOW_PROJECT_ID = _G.WOW_PROJECT_CATACLYSM_CLASSIC
elseif os.getenv('GAME_VERSION') == 'retail' then
    _G.WOW_PROJECT_ID = _G.WOW_PROJECT_MAINLINE
else
    error('Environment variable GAME_VERSION is not set or has invalid value')
end

if os.getenv('GAME_VERSION') == 'bcc' then
    MAX_PLAYER_LEVEL = 70
elseif os.getenv('GAME_VERSION') == 'retail' then
    MAX_PLAYER_LEVEL = 50
else
    MAX_PLAYER_LEVEL = 60
end

--Color.lua must be loaded to define CreateColor and ColorMixin
if CreateColor ~= nil then
    RAID_CLASS_COLORS = {
        ["HUNTER"] = CreateColor(0.67, 0.83, 0.45),
        ["WARLOCK"] = CreateColor(0.53, 0.53, 0.93),
        ["PRIEST"] = CreateColor(1.0, 1.0, 1.0),
        ["PALADIN"] = CreateColor(0.96, 0.55, 0.73),
        ["MAGE"] = CreateColor(0.25, 0.78, 0.92),
        ["ROGUE"] = CreateColor(1.0, 0.96, 0.41),
        ["DRUID"] = CreateColor(1.0, 0.49, 0.04),
        --["SHAMAN"] = CreateColor(0.0, 0.44, 0.87),
        ["SHAMAN"] = CreateColor(0.96, 0.55, 0.73),
        ["WARRIOR"] = CreateColor(0.78, 0.61, 0.43),
        ["DEATHKNIGHT"] = CreateColor(0.77, 0.12, 0.23),
        ["MONK"] = CreateColor(0.0, 1.00, 0.59),
        ["DEMONHUNTER"] = CreateColor(0.64, 0.19, 0.79),
    };

    for _, v in pairs(RAID_CLASS_COLORS) do
        v.colorStr = v:GenerateHexColor();
    end
end
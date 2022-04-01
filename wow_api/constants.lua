EXPANSION_NAME0 = "Classic"
EXPANSION_NAME1 = "The Burning Crusade"
EXPANSION_NAME2 = "Wrath of the Lich King"
EXPANSION_NAME3 = "Cataclysm"
EXPANSION_NAME4 = "Mists of Pandaria"
EXPANSION_NAME5 = "Warlords of Draenor"
EXPANSION_NAME6 = "Legion"
EXPANSION_NAME7 = "Battle for Azeroth"
EXPANSION_NAME8 = "Shadowlands"

ZONE = "Zone"

--https://wowpedia.fandom.com/wiki/WOW_PROJECT_ID
_G.WOW_PROJECT_MAINLINE = 1
_G.WOW_PROJECT_CLASSIC = 2
_G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC = 5

if os.getenv('GAME_VERSION') == 'classic' then
    _G.WOW_PROJECT_ID = _G.WOW_PROJECT_CLASSIC
elseif os.getenv('GAME_VERSION') == 'bcc' then
    _G.WOW_PROJECT_ID = _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC
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

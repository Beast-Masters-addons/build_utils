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

if os.getenv('GAME_VERSION') == 'bcc' then
    MAX_PLAYER_LEVEL = 70
else
    MAX_PLAYER_LEVEL = 60
end

if os.getenv('GAME_VERSION') == 'classic' or os.getenv('GAME_VERSION') == 'wrath' then
    loadfile('container_classic.lua')()
else
    loadfile('container_namespace.lua')()
end
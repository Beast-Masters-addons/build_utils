if os.getenv('GAME_VERSION') == 'classic' or os.getenv('GAME_VERSION') == 'wrath' then
    return loadfile('build_utils/wow_api/container_classic.lua')
else
    return loadfile('build_utils/wow_api/container_namespace.lua')
end
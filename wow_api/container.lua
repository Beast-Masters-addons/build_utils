local path = debug.getinfo(1).short_src:gsub('container.lua', '')

if os.getenv('GAME_VERSION') == 'classic' or os.getenv('GAME_VERSION') == 'wrath' then
    loadfile(path .. 'container_classic.lua')()
else
    loadfile(path .. 'container_namespace.lua')()
end
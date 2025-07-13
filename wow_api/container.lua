local path = debug.getinfo(1).source:gsub('container.lua', ''):sub(2)

if os.getenv('GAME_VERSION') == 'wrath' then
    loadfile(path .. 'container_classic.lua')()
else
    loadfile(path .. 'container_namespace.lua')()
end
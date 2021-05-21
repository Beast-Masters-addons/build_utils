if os.getenv('GAME_VERSION') == 'retail' then
    return loadfile('profession_api_retail.lua')
else
    return loadfile('profession_api_classic.lua')
end
local filename, skip = ...
if skip == nil then
    skip = {}
end
_G['AddonTable'] = {}

-- Aliases required for LibStub
_G.debugstack = debug.traceback
_G.strmatch = string.match

local function read_xml(file_name)
    local xml2lua = require("xml2lua")
    --Uses a handler that converts the XML to a Lua table
    local handler = require("xmlhandler.tree")

    local files = {}
    local folder = file_name:match("^(.+)/.+$")

    local fp = io.open(file_name)
    if fp == nil then
        error(('XML file "%s" not found'):format(file_name))
    end
    local xml = fp:read('*a')
    local parser = xml2lua.parser(handler)
    parser:parse(xml)

    for _, p in pairs(handler.root.Ui.Script) do
        local file = p._attr.file:gsub('\\', '/')
        table.insert(files, folder .. '/' .. file)
    end
    for _, p in pairs(handler.root.Ui.Include) do
        local included_file = p._attr.file:gsub('\\', '/')
        print(('%s: Include %s'):format(file_name, included_file))
        for _, sub_file in ipairs(read_xml(folder .. '/' .. included_file)) do
            table.insert(files, sub_file)
        end
    end
    return files
end

local function load_file(file_path)
    local basename = file_path:gsub('.*/', '')
    for key, value in pairs(skip) do
        if key == basename or value == basename then
            print('Skip file ' .. file_path)
            return
        end
    end

    local file = loadfile(file_path)

    if file ~= nil then
        print('Loaded ' .. file_path)
        file('TestAddon', _G['AddonTable'])
    else
        error('Unable to load file ' .. file_path)
    end
end

for line in io.lines(filename) do
    local path, basename = filename:match('(.+/)(.+toc)')
    local first = line:sub(1, 1)
    if first ~= '#' and line:len() > 1 then
        line = line:gsub('\\', '/')
        line = line:gsub('lua.*', 'lua')
        line = line:gsub('xml.*', 'xml')
        local file_path
        if first ~= '/' then
            file_path = path .. line
        else
            file_path = line
        end
        local extension = line:match("^.*%.(%a+)$")

        if extension == 'xml' then
            local files_xml = read_xml(file_path)
            for _, file in ipairs(files_xml) do
                --print('File from XML: ' .. file)
                load_file(file)
            end
        else
            load_file(file_path)
        end
    end
end


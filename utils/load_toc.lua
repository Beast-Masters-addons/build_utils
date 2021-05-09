local filename, skip = ...
if skip == nil then
    skip = {}
end
_G['AddonTable'] = {}

-- Aliases required for LibStub
_G.debugstack = debug.traceback
_G.strmatch = string.match

local function read_xml(file_name)
    local files = {}
    local folder = file_name:match("^(.+)/.+$")
    for line in io.lines(file_name) do
        local action, file = line:match('<(%a+) file="(.+)".*$')
        if file ~= nil and action == 'Script' then
            file = file:gsub('\\', '/')
            table.insert(files, folder .. '/' .. file)
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
    local first = line:sub(1, 1)
    if first ~= '#' and line:len() > 1 then
        line = line:gsub('\\', '/')
        line = line:gsub('lua.*', 'lua')
        line = line:gsub('xml.*', 'xml')
        local file_path = '../' .. line
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


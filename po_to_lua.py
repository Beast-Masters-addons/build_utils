import os
import re
import sys

import polib

from utils import build_lua_table, WowXML

folder = os.path.realpath(sys.argv[1])
xml = WowXML()

for file in os.scandir(folder):
    matches = re.search(r'([a-z]{2}[A-Z]{2})\.po', file.name)
    if not matches:
        continue

    locale = matches.group(1)
    print('Build locale %s' % locale)
    file = os.path.join(folder, '%s.po' % locale)
    pofile = polib.pofile(file)
    with open(file) as fp:
        matches = re.search(r'nplurals=([0-9]); plural=(.+);', fp.read())

    entries = {}
    for entry in pofile:
        if entry.msgstr != '':
            entries[entry.msgid] = entry.msgstr

    lua_file = os.path.join(folder, '%s.lua' % locale)
    with open(lua_file, 'w', encoding='utf8') as fp:
        entries['_plurals'] = matches.group(2)
        fp.write('local _, addon = ...\n')
        lua = build_lua_table(entries, 'addon.locales.%s' % locale)
        fp.write(lua)
        xml.script('%s.lua' % locale)

    xml.save(os.path.join(folder, 'locale.xml'))

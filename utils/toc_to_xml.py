import os
import sys
from xml.etree import ElementTree

ui = ElementTree.Element('Ui',
                         {'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance',
                          'xmlns': 'http://www.blizzard.com/wow/ui/',
                          'xsi:schemaLocation': 'http://www.blizzard.com/wow/ui/..\\FrameXML\\UI.xsd'})
print(len(sys.argv))
print(sys.argv)
folder = os.path.dirname(os.path.realpath(sys.argv[1]))
with open(sys.argv[1]) as fp:
    for line in fp.readlines():
        line = line.strip()
        if line == '' or line[0] == '#':
            continue
        file = line.replace('\\', '/')
        file = os.path.join(folder, file)
        if len(sys.argv) > 3:
            print('dirname', os.path.basename(os.path.dirname(file)))
            if line.find(sys.argv[3]) != 0:
                print('Skip %s' % file)
                continue

        if not os.path.exists(file):
            print('%s not found' % file)

        script = ElementTree.SubElement(ui, 'Script', {'file': line})
        print(line)

xml_raw = ElementTree.tostring(ui)

if len(sys.argv) > 2:
    out_file = sys.argv[2]
else:
    out_file = os.path.join(folder, 'lib.xml')

with open(out_file, 'wb') as fp:
    fp.write(xml_raw)

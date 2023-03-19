import os
import sys
import xml.etree.ElementTree as ET
from pprint import pprint

input_toc = os.path.realpath(sys.argv[1])
folder = os.path.dirname(input_toc)
output_file = os.path.join(folder, 'resolved.toc')
files = []


def get_path(file, sub_folder):
    file = file.replace('\\', os.path.sep)
    file_path = os.path.join(sub_folder, file)
    return os.path.realpath(file_path)


def parse_xml_file(file_path):
    tree = ET.parse(file_path)
    root = tree.getroot()
    sub_files = []
    xml_folder = os.path.dirname(file_path)

    for child in root:
        if child.tag == '{http://www.blizzard.com/wow/ui/}Script':
            sub_files.append(get_path(child.attrib['file'], xml_folder))
        elif child.tag == '{http://www.blizzard.com/wow/ui/}Include':
            sub_files += parse_xml_file(get_path(child.attrib['file'], xml_folder))

    return sub_files


with open(input_toc) as fp:
    for line in fp.readlines():
        if line[0] == '#' or line.strip() == '':
            continue

        file_path = get_path(line.strip(), folder)
        print(file_path)
        file_name, file_extension = os.path.splitext(file_path)
        if not os.path.exists(file_path):
            print('File not found: %s' % file_path)

        if file_extension == '.lua':
            files.append(file_path)
        elif file_extension == '.xml':
            files += parse_xml_file(file_path)

with open(output_file, 'w') as fp:
    fp.write('\n'.join(files))

pprint(files)
print('toc saved as %s' % output_file)

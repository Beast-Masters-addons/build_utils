from xml.etree import ElementTree


class WowXML:
    def __init__(self):
        self.ui = ElementTree.Element('Ui',
                                      {'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance',
                                       'xmlns': 'http://www.blizzard.com/wow/ui/',
                                       'xsi:schemaLocation': 'http://www.blizzard.com/wow/ui/ ..\\FrameXML\\UI.xsd'})

    def script(self, file):
        return ElementTree.SubElement(self.ui, 'Script', {'file': file})

    def include(self, file):
        return ElementTree.SubElement(self.ui, 'Include', {'file': file})

    def save(self, file):
        with open(file, 'wb') as fp:
            fp.write(ElementTree.tostring(self.ui))

import json
import os
import re

import requests

from utils import build_lua_list, build_lua_table


class WoWBuildUtils:
    def __init__(self, data_folder=None):
        if data_folder:
            self.data_folder = data_folder
        else:
            self.data_folder = os.path.join(os.path.dirname(__file__), '..', 'data')
        self.user_agent = 'datagutten/WoWBuildUtils'

    def get(self, url, headers=None):
        if headers is None:
            headers = {}
        if 'User-Agent' not in headers:
            headers['User-Agent'] = self.user_agent

        return requests.get(url, headers=headers)

    def file_name(self, name, extension):
        return os.path.join(self.data_folder, '%s.%s' % (name, extension))

    def save(self, data, name, save_lua=True, save_json=True):
        if save_lua:
            with open(self.file_name(name, 'lua'), 'w') as fp:
                if type(data) == dict:
                    fp.write(build_lua_table(data, "_G['%s']" % name))
                elif type(data) == list:
                    fp.write(build_lua_list(data, "_G['%s']" % name))
                else:
                    raise AttributeError('Invalid data type')

        if save_json:
            with open(self.file_name(name, 'json'), 'w') as fp:
                json.dump(data, fp)

    def art_textures(self):
        """
        Get art texture id mapped to file names
        :rtype: dict
        """
        response = self.get('https://www.townlong-yak.com/framexml/live/Helix/ArtTextureID.lua/get',
                            headers={
                                'Referer': 'https://www.townlong-yak.com/framexml/live/Helix/ArtTextureID.lua'})
        textures = {}
        matches = re.finditer(r'\[([0-9]+)]="[\w/]+/(\w+)"', response.text)
        for match in matches:
            file = match.group(2).lower()
            textures[file] = int(match.group(1))
        return textures

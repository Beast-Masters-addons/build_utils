import json
import os
import re

import requests

from .build_lua_table import build_lua_list, build_lua_table


class WoWBuildUtils:
    game_version: str = None
    """
    Game version name (wrath, cata, etc.)
    """
    data_folder: str = None
    """
    Folder to save data with subfolder for game version
    """
    data_folder_override: str = None
    """
    Manually set folder to save daa
    """

    def __init__(self, data_folder=None, game_version=None):
        self.data_folder_override = data_folder
        self.select_game_version(game_version)

        self.user_agent = 'datagutten/WoWBuildUtils'

    def select_game_version(self, game_version: str):
        game_version_env = os.getenv('GAME_VERSION')
        if not game_version and game_version_env:
            game_version = game_version_env

        if game_version:
            if game_version not in ['classic', 'wrath', 'cata', 'retail']:
                raise ValueError('Invalid game version "%s"' % format(game_version))

            self.game_version = game_version
            if not self.data_folder_override:
                self.data_folder = os.path.join(os.path.dirname(__file__), '..', 'data', game_version)

    def get(self, url, headers=None):
        if headers is None:
            headers = {}
        if 'User-Agent' not in headers:
            headers['User-Agent'] = self.user_agent

        return requests.get(url, headers=headers)

    def file_name(self, name, extension):
        return os.path.join(self.data_folder, '%s.%s' % (name, extension))

    def save(self, data, name, save_lua=True, save_json=True):
        if not os.path.exists(self.data_folder):
            os.makedirs(self.data_folder, exist_ok=True)

        if save_lua:
            with open(self.file_name(name, 'lua'), 'w', encoding="utf-8") as fp:
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
        matches = re.finditer(r'\[([0-9]+)]="[\w/]+/([\w\s]+)"', response.text)
        for match in matches:
            file = match.group(2).lower()
            textures[file] = int(match.group(1))
        return textures

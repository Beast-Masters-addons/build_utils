import csv
import json
import os
import pickle
import re
import warnings

from . import WoWBuildUtils


class WoWTables(WoWBuildUtils):
    major: int
    wow_tools_host = os.getenv('WOW_TOOLS', None) or 'http://127.0.0.1:5000'

    def __init__(self, data_folder=None, build_number=None, locale=None, game=None):
        super().__init__(data_folder, game)
        self.build_number = build_number
        self.locale = locale
        game, self.major = self.translate_build(self.game_version)

    @staticmethod
    def translate_build(product):
        if product == 'classic':
            return 'wow_classic_era', 1
        elif product == 'wrath':
            return 'wow_classic', 3
        elif product == 'cata':
            return 'wow_classic', 4
        elif product == 'mists':
            return 'wow_classic', 5
        elif product == 'retail':
            return 'wow', 11
        else:
            raise AttributeError('Unknown product name')

    def get_builds(self):
        url = '%s/casc/listManifests' % self.wow_tools_host
        return self.get(url).json()

    def select_game_version(self, game):
        super().select_game_version(game)
        if game:
            game, self.major = self.translate_build(game)

    def get_table_build(self, table):
        response = self.get('%s/listfile/db2/%s/versions' % (self.wow_tools_host, table.lower()))
        for build_info in response.json():
            build = build_info['item1']
            status = build_info['item2']

            if self.locale != 'enUS' and status != 'CASC':
                continue  # Localized data is only available from CASC

            major = re.sub(r'(\d+)\..+', r'\1', build)
            if int(major) == self.major:
                return build
        raise RuntimeError('No build found with major version %d' % self.major)

    def get_db_table(self, table):
        build = self.get_table_build(table)
        print('Get table %s for build %s' % (table, build))
        url = '%s/dbc/export/?name=%s&build=%s' % (self.wow_tools_host, table, build)
        if self.locale:
            url += '&locale=%s' % self.locale
        response = self.get(url)
        if response.status_code == 200:
            return csv.DictReader(response.text.splitlines())
        else:
            raise RuntimeError('Status code %d, URL %s' % (response.status_code, url))

    def get_db_table_cache(self, table_name):
        warnings.deprecated("Use WoWTablesCache class")
        build_num = self.get_table_build(table_name)
        file = '%s_%s.json' % (table_name, build_num)
        file = os.path.join(self.data_folder, file)
        if os.path.exists(file):
            try:
                with open(file, 'r') as fp:
                    return json.load(fp)
            except json.JSONDecodeError:
                pass
        table_data = list(self.get_db_table(table_name))
        with open(file, 'w') as fp:
            json.dump(table_data, fp)
        return table_data


class WowTablesCache(WoWTables):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._cache_path = os.getenv('TABLE_CACHE_PATH', '')
        if self.locale != 'enUS':
            self._cache_path = os.path.join(self._cache_path, self.locale)

    def get_db_table(self, table):
        build = self.get_table_build(table)
        cache_folder = os.path.join(self._cache_path, build)

        cache_file = os.path.join(cache_folder, '%s.pickle' % table)
        if os.path.exists(cache_file):
            with open(cache_file, 'rb') as fp:
                return pickle.load(fp)
        else:
            data = list(super().get_db_table(table))
            os.makedirs(cache_folder, exist_ok=True)
            with open(cache_file, 'wb') as fp:
                pickle.dump(data, fp)
            return data

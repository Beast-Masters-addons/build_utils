import csv
import os
import re

from . import WoWBuildUtils


class WoWTables(WoWBuildUtils):
    major: int
    wow_tools_host = os.getenv('WOW_TOOLS', None) or 'http://127.0.0.1:5000'

    def __init__(self, data_folder=None, build_number=None, locale=None, game='wrath'):
        super().__init__(data_folder=data_folder)
        self.game = game
        self.build_number = build_number
        self.locale = locale
        game, self.major = self.translate_build(game)
        self.select_build(game)

    @staticmethod
    def translate_build(product):
        if product == 'classic':
            return 'wow_classic_era', 1
        elif product == 'cata':
            return 'wow_classic', 4
        elif product == 'retail':
            return 'wow', 11
        else:
            raise AttributeError('Unknown product name')

    def get_builds(self):
        url = '%s/casc/listManifests' % self.wow_tools_host
        return self.get(url).json()

    def select_build(self, product):
        url = '%s/casc/switchProduct?product=%s' % (self.wow_tools_host, product)
        response = self.get(url)
        response.raise_for_status()

    def get_table_build(self, table):
        response = self.get('%s/listfile/db2/%s/versions' % (self.wow_tools_host, table))
        for build in response.json():
            if type(build) is dict:
                build = build['item1']
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

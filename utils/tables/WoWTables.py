import csv
import os
import re

from . import WoWBuildUtils


class WoWTables(WoWBuildUtils):
    wow_tools_host = os.getenv('WOW_TOOLS', None) or 'http://127.0.0.1:5000'

    def __init__(self, data_folder=None, build_number=None, locale=None, game_version=None):
        super().__init__(data_folder=data_folder, game_version=game_version)
        if not build_number:
            self.build_number = self.get_build()
        else:
            self.build_number = build_number
        self.locale = locale
        self.select_build(self.translate_build(self.game_version))

    def get_build(self):
        builds = self.get_builds()
        major = {'classic': 1, 'wrath': 3, 'retail': 10}[self.game_version]
        for build in builds:
            if int(re.sub(r'(\d+)\..+', r'\1', build)) == major:
                return build
        raise RuntimeError('No build with major version %d found' % format(major))

    @staticmethod
    def translate_build(product):
        if product == 'classic':
            return 'wow_classic_era'
        elif product == 'wrath':
            return 'wow_classic'
        elif product == 'retail':
            return 'wow'

    def get_builds(self):
        url = '%s/casc/listManifests' % self.wow_tools_host
        return self.get(url).json()

    def select_build(self, product):
        url = '%s/casc/switchProduct?product=%s' % (self.wow_tools_host, product)
        response = self.get(url)
        response.raise_for_status()

    def get_table_builds(self, table):
        response = self.get('%s/listfile/db2/%s/versions' % (self.wow_tools_host, table))
        return response.json()

    def get_db_table(self, table):
        url = '%s/dbc/export/?name=%s&build=%s' % (self.wow_tools_host, table, self.build_number)
        if self.locale:
            url += '&locale=%s' % self.locale
        response = self.get(url)
        if response.status_code == 200:
            return csv.DictReader(response.text.splitlines())
        else:
            raise RuntimeError('Status code %d, URL %s' % (response.status_code, url))

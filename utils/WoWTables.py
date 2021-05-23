import csv
import os

from WoWBuildUtils import WoWBuildUtils


class WoWTables(WoWBuildUtils):
    def __init__(self, data_folder=None, build_number='2.5.1.38537', locale=None):
        super().__init__(data_folder=data_folder)
        self.build_number = build_number
        self.locale = locale

    @staticmethod
    def get_build(game_version=None):
        version = game_version or os.getenv('GAME_VERSION')
        if version == 'classic':
            return '1.13.7.38704'
        elif version == 'bcc':
            return '2.5.1.38757'
        else:
            return '9.1.0.38709'

    def get_db_table(self, table):
        url = 'https://wow.tools/dbc/api/export/?name=%s&build=%s' % (table, self.build_number)
        if self.locale:
            url += '&locale=%s' % self.locale
        response = self.get(url)
        if response.status_code == 200:
            return csv.DictReader(response.text.splitlines())
        else:
            raise RuntimeError('Status code %d, URL %s' % (response.status_code, url))

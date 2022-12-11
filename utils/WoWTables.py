import csv
import os

try:
    from WoWBuildUtils import WoWBuildUtils
except ImportError:
    from .WoWBuildUtils import WoWBuildUtils


class WoWTables(WoWBuildUtils):
    def __init__(self, data_folder=None, build_number='2.5.1.38537', locale=None, game='wrath'):
        super().__init__(data_folder=data_folder)
        self.game = game
        self.build_number = build_number
        self.locale = locale

    @staticmethod
    def get_build(game_version=None):
        version = game_version or os.getenv('GAME_VERSION')
        if version == 'classic':
            return '1.4.3.42926'
        elif version == 'bcc':
            return '2.5.4.42940'
        elif version == 'wrath':
            return '3.4.0.45770'
        else:
            return '9.2.5.42850'

    def get_db_table(self, table):
        url = 'https://wow.tools/dbc/api/export/?name=%s&build=%s' % (table, self.build_number)
        if self.locale:
            url += '&locale=%s' % self.locale
        response = self.get(url)
        if response.status_code == 200:
            return csv.DictReader(response.text.splitlines())
        else:
            raise RuntimeError('Status code %d, URL %s' % (response.status_code, url))

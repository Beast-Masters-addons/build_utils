import csv

from . import WoWBuildUtils


class WoWTables(WoWBuildUtils):
    def get_db_table(self, table, build_number='2.5.1.38537', locale=None):
        url = 'https://wow.tools/dbc/api/export/?name=%s&build=%s' % (table, build_number)
        if locale:
            url += '&locale=%s' % locale
        response = self.get(url)
        if response.status_code == 200:
            return csv.DictReader(response.text.splitlines())
        else:
            raise RuntimeError('Status code %d, URL %s' % (response.status_code, url))


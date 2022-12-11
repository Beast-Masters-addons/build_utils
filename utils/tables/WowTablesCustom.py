import csv
import os.path

import requests

from .WoWTables import WoWTables


class WoWTablesCustom(WoWTables):
    base_url = 'https://dedicated.datagutten.net/wow_tables'

    def get_db_table(self, table):
        response_version = requests.get(
            '%s/latest_build.php?game=%s' % (self.base_url, self.game))
        self.build_number = response_version.text

        folder = os.path.join(self.data_folder, 'tables', self.build_number)
        if self.locale:
            folder = os.path.join(folder, self.locale)
        if not os.path.exists(folder):
            os.makedirs(folder, exist_ok=True)

        file = os.path.join(folder, table + '.csv')
        if not os.path.exists(file):
            url = '%s/extract_table_web.php?table=%s&game=%s' % (self.base_url,
                                                                 table, self.game)
            if self.locale:
                url += '&locale=%s' % self.locale
            response = self.get(url)
            if response.status_code != 200:
                raise RuntimeError('Status code %d, URL %s' % (response.status_code, url))
            with open(file, 'wb') as fp:
                fp.write(response.content)

        with open(file, errors='ignore') as fp2:
            return csv.DictReader(fp2.read().splitlines())

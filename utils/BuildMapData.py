import os

from utils.WowTablesCustom import WoWTablesCustom

try:
    from WoWTables import WoWTables
except ImportError:
    from .WoWTables import WoWTables


class BuildMapData(WoWTablesCustom):
    def map_to_area(self):
        table = self.get_db_table('uimapassignment')
        maps = {}
        for row in table:
            # print(row['AreaID'], row['AreaID'] == 0)
            area = int(row['AreaID'])
            if area == 0:
                continue
            maps[int(row['UiMapID'])] = area
        return maps

    def map_info(self):
        table = self.get_db_table('uimap')
        maps = {}
        for row in table:
            maps[int(row['ID'])] = dict(row)
        return maps

    def area_info(self):
        import json
        with open(self.file_name('MapToZone', 'json')) as fp:
            map_to_zone = json.load(fp)
            zone_to_map = dict(zip(map_to_zone.values(), map_to_zone.keys()))
        table = self.get_db_table('areatable')
        map_info = {}
        for row in table:
            zone_id = int(row['ID'])
            row['zoneID'] = zone_id
            if zone_id not in zone_to_map:
                if int(row['ParentAreaID']) in zone_to_map:
                    map_id = zone_to_map[int(row['ParentAreaID'])]
                    if map_id in map_info:
                        continue
                else:
                    # print('No map for Zone %d %s' % (zone_id, row['ZoneName']))
                    continue
            else:
                map_id = int(zone_to_map[zone_id])
            map_info[map_id] = dict(row)

        return map_info


if __name__ == "__main__":
    version = os.getenv('GAME_VERSION')
    if version == 'classic':
        build = '1.13.7.38704'
    elif version == 'bcc':
        build = '2.5.1.38757'
    elif version == 'wrath':
        build = '3.4.0.45770'
    else:
        build = '10.0.0.46366'
    build = BuildMapData(build_number=build, game=version)

    build.save(build.map_to_area(), 'MapToZone')
    build.save(build.map_info(), 'MapInfo')
    build.save(build.area_info(), 'AreaInfo')

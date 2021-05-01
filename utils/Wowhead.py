import json
import os
import re
import subprocess

import requests

from . import WoWBuildUtils


class Wowhead(WoWBuildUtils):
    def get(self, url=None, domain=None, element=None, key=None, uri=None):
        if not domain:
            if os.getenv('WOWHEAD_DOMAIN'):
                domain = os.getenv('WOWHEAD_DOMAIN')
            else:
                domain = 'tbc'

        if not url:
            url = 'https://%s.wowhead.com' % domain
            if element and key:
                url += '/%s=%d' % (element, key)
            if uri:
                url += uri
        return super(Wowhead, self).get(url)

    @staticmethod
    def clean_json(json_string):
        # Fix unquoted keys
        # json_string = re.sub(r',(\s*)([^"]+?):', r',\1"\2":', json_string)
        json_string = re.sub(r',(\s*)([^"]+?):(\s?(?:\[.+?]|["a-zA-Z0-9]+))', r',\1"\2":\3', json_string)
        # Pattern matches too much when two keys missing quotes
        json_string = re.sub(r',(\s*)([^"]+?):(\s?(?:\[.+?]|["a-zA-Z0-9]+))', r',\1"\2":\3', json_string)
        # json = str_replace("'", '',json) # Remove single quotes
        json_string = re.sub(r'/"([0-9]+],)(pctstack":{)([0-9]+)/', '$1"$2"$3"', json_string)
        return json_string

    @staticmethod
    def js_array_to_json(array, name=None):
        if not name:
            matches = re.search(r'var (\w+)\s?=', array)
            name = matches.group(1)
        js = array
        js += ';\nconsole.log(JSON.stringify(%s))' % name
        with open('temp.js', 'w') as fp:
            fp.write(js)
            json_string = subprocess.check_output(['node', 'temp.js'])
            data = json.loads(json_string)
        os.unlink('temp.js')
        return data

    @staticmethod
    def get_list_view(response: requests.Response, list_id):
        pattern = r"new Listview.+id: '%s'.+data:\s?(\[.+\])" % list_id
        match = re.search(pattern, response.text)
        if not match:
            raise ValueError('No list with id %s' % list_id)
        try:
            return json.loads(Wowhead.clean_json(match[1]))
        except json.decoder.JSONDecodeError as e:
            print(match[1])
            raise e

    @staticmethod
    def get_list_data(response: requests.Response, name):
        matches = re.search(r'var %s\s?=\s?(\[.+])' % name, response.text)
        return Wowhead.js_array_to_json(matches.group(0), name)

    @staticmethod
    def get_gatherer_data(response: requests.Response):
        matches = re.search(r'WH\.Gatherer\.addData\(.+?({.+})\);', response.text)
        return json.loads(matches.group(1))

import os

import dotenv
from wlc import Weblate

# https://community.developer.battle.net/documentation/world-of-warcraft/guides/localization

language_mappings = {
    'en': 'enUS',
    'zh_Hans': 'zh_TW',
    'zh_Hant': 'zh_CN'
}

dotenv.load_dotenv()


def convert_language_code(language_code: str):
    if language_code in language_mappings:
        return language_mappings[language_code]
    elif len(language_code) == 2:
        return language_code + language_code.upper()
    elif len(language_code) == 5:
        return language_code[:2] + language_code[3:]
    else:
        raise RuntimeError("Unable to convert language code %s" % language_code)


class WeblateHelper(Weblate):
    def __init__(self, *args, **kwargs):
        super().__init__(os.environ.get('WEBLATE_API_KEY'), os.environ.get('WEBLATE_URL'), *args, *kwargs)

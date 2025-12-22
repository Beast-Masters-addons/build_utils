import os

import pytest

from utils.Wowhead import Wowhead

games = [
    ['classic'],
    ['bcc'],
    ['wrath'],
    ['cata'],
    ['mists'],
    ['retail'],
]


@pytest.mark.parametrize(['game'], games)
def test_path_arg(game):
    wowhead = Wowhead(game_version=game)
    pet = wowhead.query(element='pet', key=4)
    if game == 'retail':
        url = 'https://www.wowhead.com/pet=4/bear'
    else:
        url = 'https://www.wowhead.com/%s/pet=4/bear' % wowhead.paths[game]
    assert pet.url == url


@pytest.mark.parametrize(['game'], games)
def test_path_arg2(game):
    wowhead = Wowhead()
    pet = wowhead.query(game=game, element='pet', key=4)
    if game == 'retail':
        url = 'https://www.wowhead.com/pet=4/bear'
    else:
        url = 'https://www.wowhead.com/%s/pet=4/bear' % wowhead.paths[game]
    assert pet.url == url


@pytest.mark.parametrize(['game'], games)
def test_path_env(game):
    os.environ['GAME_VERSION'] = game
    wowhead = Wowhead()
    pet = wowhead.query(element='pet', key=4)
    if game == 'retail':
        url = 'https://www.wowhead.com/pet=4/bear'
    else:
        url = 'https://www.wowhead.com/%s/pet=4/bear' % wowhead.paths[game]
    assert pet.url == url

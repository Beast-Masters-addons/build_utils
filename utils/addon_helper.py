import glob
import os
from pathlib import Path


def find_addon_root(folder: Path) -> Path:
    for name in ['.pkgmeta', '.git', 'README.md']:
        if os.path.exists(folder.joinpath(name)):
            return folder

    return find_addon_root(folder.parent)


def find_toc(root_folder: Path) -> Path:
    toc = glob.glob(str(root_folder.joinpath('*.toc')))
    if toc:
        return Path(toc[0])
    raise FileNotFoundError


def addon_key(root_folder: Path):
    try:
        import yaml
        if os.path.exists(root_folder.joinpath('.pkgmeta')):
            with open(root_folder.joinpath('.pkgmeta')) as fp:
                meta = yaml.load(fp, yaml.SafeLoader)
                if 'package-as' in meta:
                    return meta['package-as']
    except ImportError:
        pass

    return root_folder.name

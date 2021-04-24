def build_lua_table(source: dict, name='data', indent_size=4, indent_level=1) -> str:
    """
    Convert a python dict to a lua table
    :param source: Source dict
    :param name: Table name
    :param indent_size: Indentation size
    :param indent_level: Indentation level
    :return: lua table
    """
    if name:
        table = '%s = {\n' % name
    else:
        table = '{\n'
    for key, value in source.items():
        if type(key) == int:
            key = '[%d]' % key

        table += ' ' * indent_size * indent_level
        if type(value) == str:
            table += '%s = "%s"' % (key, value)
        elif type(value) == int:
            table += '%s = %d' % (key, value)
        elif type(value) == list:
            table += '%s = {' % key
            for item in value:
                if type(item) == str:
                    table += '"%s",' % item
                elif type(item) == int:
                    table += ' %d,' % item
                else:
                    raise Exception('Unhandled type: ' + type(item))
            table = table[:-1]
            table += ' }'
        elif type(value) == dict:
            table += build_lua_table(value, key, indent_size=indent_size, indent_level=indent_level + 1)
        else:
            raise Exception('Unhandled type: %s' % type(value))

        table += ',\n'
    table += ' ' * indent_size * (indent_level - 1) + '}'
    return table

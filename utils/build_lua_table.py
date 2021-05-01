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
        elif type(key) == str:
            key = '["%s"]' % key
        else:
            raise ValueError('Unsupported key type: %s' % type(key))

        table += ' ' * indent_size * indent_level
        if type(value) == str:
            value = value.replace('"', '\\"')
            table += '%s = "%s"' % (key, value)
        elif type(value) == int:
            table += '%s = %d' % (key, value)
        elif type(value) == bool:
            if value:
                table += '%s = true' % key
            else:
                table += '%s = false' % key
        elif type(value) == list:
            table += '%s = {' % key
            if len(value) == 0:
                table += '}'
            else:
                for item in value:
                    if type(item) == str:
                        table += ' "%s",' % item
                    elif type(item) == int:
                        table += ' %d,' % item
                    elif item is None:
                        table += ' nil,'
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


def build_lua_list(source: list, name='data', indent_size=4, indent_level=1):
    if name:
        table = '%s = {\n' % name
    else:
        table = '{\n'

    for value in source:
        table += ' ' * indent_size * indent_level
        if type(value) == str:
            table += '"%s"' % value
        elif type(value) == int:
            table += '%d' % value
        elif type(value) == list:
            table += '{'
            if len(value) == 0:
                table += '}'
            else:
                for item in value:
                    if type(item) == str:
                        table += ' "%s",' % item
                    elif type(item) == int:
                        table += ' %d,' % item
                    elif item is None:
                        table += ' nil,'
                    else:
                        raise Exception('Unhandled type: ' + type(item))
                table = table[:-1]
                table += ' }'
        elif type(value) == dict:
            table += build_lua_table(value, None, indent_size=indent_size, indent_level=indent_level + 1)
        else:
            raise Exception('Unhandled type: %s' % type(value))

        table += ',\n'
    table += ' ' * indent_size * (indent_level - 1) + '}'
    return table

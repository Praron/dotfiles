#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# This script is a simple wrapper which prefixes each i3status line with custom
# information. It is a python reimplementation of:
# http://code.stapelberg.de/git/i3status/tree/contrib/wrapper.pl
#
# To use it, ensure your ~/.i3status.conf contains this line:
#     output_format = "i3bar"
# in the 'general' section.
# Then, in your ~/.i3/config, use:
#     status_command i3status | ~/i3status/contrib/wrapper.py
# In the 'bar' section.
#
# In its current version it will display the cpu frequency governor, but you
# are free to change it to display whatever you like, see the comment in the
# source code below.
#
# © 2012 Valentin Haenel <valentin.haenel@gmx.de>
#
# This program is free software. It comes without any warranty, to the extent
# permitted by applicable law. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License (WTFPL), Version
# 2, as published by Sam Hocevar. See http://sam.zoy.org/wtfpl/COPYING for more
# details.

import sys
import json
import time
from subprocess import check_output, CalledProcessError
from re import compile, search, split, findall


def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()


def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sys.exit()


if __name__ == '__main__':
    # Skip the first line which contains the version header.
    print_line(read_line())
    # The second line contains the start of the infinite array.
    print_line(read_line())

    while True:
        line, prefix = read_line(), ''
        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','

        j = json.loads(line)

        # _xkb = (search('LED mask: *[0-9]*',
        #         check_output(['xset', '-q']).decode()).group(0))
        # xkb = search('[0-9]*$', _xkb).group(0)

        keymap = str(check_output(['setxkbmap', '-query']).decode())
        keymap = search('layout.*', keymap).group(0)
        keymap = split(' ', keymap)[-1]

        if keymap == 'us':
            j.insert(0, {'full_text': 'EN', 'name': 'lang', 'color': '009E00'})
        else:
            j.insert(0, {'full_text': 'RU', 'name': 'lang', 'color': 'dddd00'})

        # try:
        #     cmus_remote = check_output(['cmus-remote', '-Q']).decode('utf-8')
        #     status = cmus_remote.split('\n')[0].split()[1]
        # except CalledProcessError:
        #     status = 'not open'

        # if status == 'playing':
        #     l = []
        #     p = compile('tag (artist|album|title|date|genre|tracknumber) ')
        #     for e in cmus_remote.split('\n'):
        #         if p.match(e):
        #             l.append(p.sub('', e).title())
        #             # l[0] is "Artist", l[1] is "Album", l[2] is "Title"
        #     if len(l) > 2:
        #         j.insert(0, {'full_text': '{0} - {2} '
        #                                   .format(l[0], l[1], l[2]),
        #                                   'name': 'cmus'})
        # else:
        #     clipboard = check_output(['xclip', '-selection', 'clipboard', '-o']).decode('utf-8')[0:100]
        #     if (len(clipboard) > 99):
        #         clipboard += '...'
        #     j.insert(0, {'full_text': clipboard, 'name': 'clipboard'})
        #     j.insert(0, {'full_text': 'CB:', 'name': 'cb_label', 'color': '009E00'})
        #     pass

        cpu_temp = int(findall('[0-9]+', check_output(['tlp-stat', '-t']).decode('utf-8').split('\n')[3])[0])
        cpu_color = 'ffffff'
        if cpu_temp < 55:
            cpu_color = '009E00'
        elif cpu_temp < 70:
            cpu_color = 'dddd00'
        else:
            cpu_color = 'dd0000'
        j.insert(3, {'full_text': str(' CPU: ' + str(cpu_temp) + '°C '), 'name': 'cpu_temp', 'color': cpu_color})

        print_line(prefix + json.dumps(j))
        time.sleep(0.5)

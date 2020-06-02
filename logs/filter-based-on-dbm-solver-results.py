#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2020 Shlomi Fish <shlomif@cpan.org>
#
# Distributed under terms of the MIT license.

import glob
import re

filtered = set()
for fn in sorted(glob.glob(
        "./dbm-fc-solver--on-shlomif-nuc--logs/deal-*/*.dump")):
    m = re.match(
        "^\\./dbm-fc-solver--on-shlomif-nuc--logs/" +
        "deal-([0-9]+)/\\1\\.dump$", fn)
    assert m
    deal_idx = int(m.group(1))
    assert deal_idx not in filtered
    found = False
    for line in open(fn, 'rt'):
        if re.match("^[0-9]+\\.[0-9]+\\tCould not solve successfully\\.$",
                    line):
            found = True
            break
    assert found, "deal_idx = {} ( from {} ) failed!".format(deal_idx, fn)

    filtered.add(deal_idx)

with open("intractable2.txt", "wt") as out:
    with open("intractable1.txt", "rt") as infh:
        for line in infh:
            deal_idx = int(line)
            if deal_idx not in filtered:
                out.write('{}\n'.format(deal_idx))
            else:
                filtered.remove(deal_idx)

assert (len(filtered) == 0)

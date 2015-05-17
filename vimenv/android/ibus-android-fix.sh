#!/bin/bash

# Solution from:
# https://code.google.com/p/ibus/issues/detail?id=1733

ibus exit
env IBUS_ENABLE_SYNC_MODE=1 ibus-daemon --xim &

#!/usr/bin/env python
#
# Copyright 2011 Nick Mathewson, Michael Stone
# Copyright 2013 The Tor Project
#
#  You may do anything with this work that copyright law would normally
#  restrict, so long as you retain the above notice(s) and this license
#  in all redistributed copies and derived works.  There is no warranty.

# Future imports for Python 2.7, mandatory in 3.0
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

import os
import sys

# Set debug_flag=True in order to debug this program or to get hints
# about what's going wrong in your system.
debug_flag = os.environ.get("CHUTNEY_DEBUG", "") != ""

def debug(s):
    "Print a debug message on stdout if debug_flag is True."
    if debug_flag:
        print("DEBUG: %s" % s)


def main():
    global debug_flag
    debug("This message should appear if $CHUTNEY_DEBUG is true.")
    debug_flag = True
    debug("This message should always appear.")
    debug_flag = False
    debug("This message should never appear.")
    # We don't test tracebacks, because it's hard to know what to expect
    # (and they make python exit with a non-zero exit status)
    return 0

if __name__ == '__main__':
    sys.exit(main())

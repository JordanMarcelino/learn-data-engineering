#!/bin/bash/env python3
"""mapper.py"""

import sys

for line in sys.stdin:
    words = line.strip().split()

    for word in words:
        print(f"{word}\t{1}")

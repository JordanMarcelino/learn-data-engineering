#!/bin/bash/env python3
"""reducer.py"""

import sys

current_word = None
current_count = 0

for line in sys.stdin:
    word, count = line.strip().split("\t", 1)

    try:
        count = int(count)
    except ValueError:
        continue

    if current_word == word:
        current_count += 1
        continue

    if current_word:
        print(f"{current_word}\t{count}")

    current_word = word
    current_count = count

if current_word == word:
    print(f"{current_word}\t{count}")

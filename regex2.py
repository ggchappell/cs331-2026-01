#!/usr/bin/env python3
# regex2.py
# Glenn G. Chappell
# 2026-01-13
#
# For CS 331 Spring 2026
"""Demo of regular expressions in Python."""

import re   # For .search
import sys  # for .stdin, .exit


# ****************************************************
# * EDIT THE FOLLOWING line TO CHANGE THE REGEX USED *
# ****************************************************
regex1 = r"[ab]c*d"  # Our regular expression
# Note. r"..." gives a "raw" string literal, without backslash escaping.


def main():
    """Read stdin, print info on regex matches with each line."""

    print("Demonstration of Regexes in Python")
    print("Type strings to attempt to match.")
    print("See the source code to change the regex used.")
    print()

    for line in (sys.stdin):
        line = line.rstrip("\r\n")  # Remove EOL chars

        # Try to match with our regex. Print info on results.
        if (match_obj := re.search(regex1, line)):
            print(f"{line}: MATCHED [{match_obj[0]}]")
        else:
            print(f"{line}: no match")

    return 0


# Main program
# If this module is executed as a program (instead of being imported):
# run function main.
if __name__ == "__main__":
    sys.exit(main())


# sum_last.awk
# Glenn G. Chappell
# 2026-01-26
#
# For CS 331 Spring 2026
# Output the sum of the last word on each line
# Demo of AWK

# To run on command line:
#   awk -f sum_last.awk


BEGIN { total = 0 }

{
    total += $NF
}

END { print "Total:", total }


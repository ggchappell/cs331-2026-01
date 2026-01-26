#!/usr/bin/env perl
# sum_last.pl
# Glenn G. Chappell
# 2026-01-26
#
# For CS 331 Spring 2026
# Output the sum of the last word on each line
# Demo of Perl


$total = 0;

while (<>) {
    @_ = split;
    $total += $_[-1];
}

print "Total: $total\n";


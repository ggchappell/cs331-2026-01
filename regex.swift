#!/usr/bin/env swift
// regex.swift
// Glenn G. Chappell
// 2026-01-13
//
// For CS 331 Spring 2026
// Demo of regular expressions in Swift


// ****************************************************
// * EDIT THE FOLLOWING LINE TO CHANGE THE REGEX USED *
// ****************************************************
let regex1 = #/[ab]c*d/#  // Our regular expression
// Note. Above, the "#" characters are optional in Swift 6.

print("Demonstration of Regexes in Swift")
print("Type strings to attempt to match.")
print("See the source code to change the regex used.")
print()

// Read stdin, print info on regex matches with each line.
while let line = readLine() {
    // Try to match with our regex. Print info on results.
    if let match = line.firstMatch(of: regex1) {
        print("\(line): MATCHED [\(match.output)]")
    }
    else {
        print("\(line): no match")
    }
}


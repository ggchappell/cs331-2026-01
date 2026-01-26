// func_array.swift
// Glenn G. Chappell
// 2026-01-26
//
// For CS 331 Spring 2026
// Demo of Array of Functions in Swift

// Do import for fflush, stdout
#if os(Windows)
import ucrt
#elseif os(Linux)
import Glibc
#else  // Apple OSs
import Darwin.C
#endif


// userPause
// Wait for user to press ENTER: read all chars through first newline.
func userPause() {
    fflush(stdout)
    _ = readLine()
}


// Main program
// Make vector of lambda functions and call one of them.


// Make array of functions
var funcs: [() -> Void] = [
    { () -> Void in print("Zero") },
    { () -> Void in print("One") },
    { () -> Void in print("Two") },
    { () -> Void in print("Three") },
    { () -> Void in print("Four") },
    { () -> Void in print("Five") },
    { () -> Void in print("Six") },
    { () -> Void in print("Seven") },
    { () -> Void in print("Eight") },
    { () -> Void in print("Nine") },
    { () -> Void in print("Ten") },
]

// Set our index variable
let i = 7

// Print introductory message
print("Demonstration of Array of Lambda Functions in Swift")
print("See the source code for details.")
print()

// Call one of the above functions, using an array look-up
print("i = ", i)
print("Result of function call: ", terminator: "")
funcs[i]()
print()

// Wait for user
print("Press ENTER to quit ", terminator: "")
userPause()


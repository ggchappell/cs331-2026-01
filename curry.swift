#!/usr/bin/env swift
// curry.swift  UNFINISHED
// Glenn G. Chappell
// 2026-02-22
//
// For CS 331 Spring 2026
// Currying in Swift
// Based on closure.swift

// Do import for fflush, stdout
#if os(Windows)
import ucrt
#elseif os(Linux)
import Glibc
#else  // Apple OSs
import Darwin.C
#endif


// Function multiply copied from file closure.swift

// multiply
// Return a function object (a closure) that multiplies by the given k.
func multiply(_ k: Int) -> (Int) -> Int {
    func doit(_ x: Int) -> Int {
        return k * x
    }

    return doit
}


// userPause
// Wait for user to press ENTER: read all chars through first newline.
func userPause() {
    fflush(stdout)
    _ = readLine()
}


// Main program
// Demonstrate multiply with and without currying.
print("Demonstration of Currying in Swift")
print("See the source code for details.")
print()

let times2 = multiply(2)

print("2 times 300 is \(times2(300)).")
print()

// TO DO: WRITE SOMETHING HERE!!!

// Wait for user
print("Press ENTER to quit ", terminator: "")
userPause()


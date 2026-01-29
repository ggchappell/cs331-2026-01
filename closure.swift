// closure.swift
// Glenn G. Chappell
// 2026-01-29
//
// For CS 331 Spring 2026
// Swift Closures

// Do import for fflush, stdout
#if os(Windows)
import ucrt
#elseif os(Linux)
import Glibc
#else  // Apple OSs
import Darwin.C
#endif


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
// Demonstrate multiply by creating some closures and using them.
print("Demonstration of Closures in Swift")
print("See the source code for details.")
print()

let times2 = multiply(2)
let triple = multiply(3)
let times7 = multiply(7)

print("300 times 2 is ", times2(300), ".", separator: "")
print("25 tripled is ", triple(25), ".", separator: "")
print("10 times 7 is ", times7(10), ".", separator: "")
print()

// Wait for user
print("Press ENTER to quit ", terminator: "")
userPause()


// func_array2.cpp
// Glenn G. Chappell
// 2026-01-26
//
// For CS 331 Spring 2026
// Demo of Array of Functions in C++

#include <iostream>
using std::cout;
using std::cin;
#include <functional>
using std::function;
#include <vector>
using std::vector;


// userPause
// Wait for user to press ENTER: read all chars through first newline.
void userPause()
{
    std::cout.flush();
    while (std::cin.get() != '\n') ;
}


// Main program
// Make vector of lambda functions and call one of them.
int main()
{
    // Make vector of lambda functions
    vector<function<void()>> funcs {
        []() { cout << "Zero\n"; },
        []() { cout << "One\n"; },
        []() { cout << "Two\n"; },
        []() { cout << "Three\n"; },
        []() { cout << "Four\n"; },
        []() { cout << "Five\n"; },
        []() { cout << "Six\n"; },
        []() { cout << "Seven\n"; },
        []() { cout << "Eight\n"; },
        []() { cout << "Nine\n"; },
        []() { cout << "Ten\n"; }
    };

    // Set our index variable
    int i = 7;

    // Print introductory message
    cout << "Demonstration of Array of Lambda Functions in C++\n";
    cout << "See the source code for details.\n";
    cout << "\n";

    // Call one of the above functions, using a vector look-up
    cout << "i = " << i << "\n";
    cout << "Result of function call: ";
    funcs[i]();
    cout << "\n";

    // Wait for user
    cout << "Press ENTER to quit ";
    userPause();
}


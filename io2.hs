-- io2.hs
-- Glenn G. Chappell
-- 2026-03-02
--
-- For CS 331 Spring 2026
-- Code from Mar 2 - Haskell: I/O II

module Main where

import System.IO  -- for hFlush, stdout


main = do
    putStrLn ""
    putStrLn "This file contains sample code from March 2, 2026,"
    putStrLn "for the topic \"Haskell: I/O II\"."
    putStrLn "It will execute, but it is not intended to do anything"
    putStrLn "useful. See the source."
    putStrLn ""


-- ***** Do-Expression *****


-- The do-expression is simple syntactic sugar around the ">>" and
-- ">>=" operators.

-- inputLength
-- Input a line from the user, and print a message giving its length.
inputLength = do
    putStr "Type some text: "
    hFlush stdout      -- Make sure prompt comes before input
    line <- getLine
    putStrLn ""
    putStr "You typed: "
    putStrLn line
    putStr "Length of your line = "
    putStrLn $ show $ length line

-- Try:
--   inputLength

-- Note that, inside an I/O do-expression, NAME <- IO_ACTION binds NAME
-- to the value wrapped by IO_ACTION.


-- ***** return *****


-- Inside an I/O do-expression, "return" creates a do-nothing I/O action
-- wrapping a value of our choice. It does NOT return.
--
--     return x
-- gives a no-side-effect I/O action wrapping the value x.
--
--     return ()
-- gives a no-side-effect I/O action wrapping a "nothing" value.

-- myGetLine
-- Same as getLine, but showing how to write it.
-- Uses "return".
myGetLine = do
    c <- getChar  -- getChar does what you think;
                  --  return value is I/O-wrapped Char
    if c == '\n'
    then return ""
    else do
        rest <- myGetLine
        return (c:rest)

-- Note: Expressions in an I/O do-expression need to return I/O actions,
-- but they can be complicated expressions, like if-then-else above.

-- inputLength'
-- Same as inputLength, but rewritten to use myGetLine.
inputLength' = do
    putStr "Type some text: "
    hFlush stdout      -- Make sure prompt comes before input
    line <- myGetLine  -- Use our version of getLine
    putStrLn ""
    putStr "You crazy devil, you just typed: "
    putStrLn line
    putStr "Length of your line = "
    putStrLn $ show $ length line

-- Try:
--   inputLength'


-- ***** "let" In a Do-Expression *****


-- Final bit of do-expression syntax:
--   let NAME = EXPRESSION
-- binds a name to a NON-I/O value, for remainder of do-expression.

-- squareNums
-- Repeatedly input a number from the user. If 0, then quit; otherwise
-- print its square, and repeat.
squareNums = do
    putStr "Type an integer (0 to quit): "
    hFlush stdout       -- Make sure prompt comes before input
    line <- getLine     -- Bind name to I/O-wrapped value
    let n = read line   -- Bind name to non-I/O value
                        -- Compiler knows n is Integer by how we use it
    if n == 0
    then return ()  -- Must have I/O action here, but there are no side
                    --  effects to perform and nothing it needs to wrap.
    else do
        putStrLn ""
        putStr "The square of your number is: "
        putStrLn $ show $ n*n
        putStrLn ""
        squareNums    -- Repeat

-- Try:
--   squareNums

-- Also see file squarenums.hs


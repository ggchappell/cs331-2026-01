#!/usr/bin/env lua
-- use_parseit.lua
-- Glenn G. Chappell
-- 2026-02-17
--
-- For CS 331 Spring 2026
-- Simple Main Program for parseit Module
-- Requires parseit.lua

parseit = require "parseit"


-- String forms of symbolic constants
-- Used by printAST
symbolNames = {
  [1]="PROGRAM",
  [2]="EMPTY_STMT",
  [3]="PRINT_STMT",
  [4]="PRINTLN_STMT",
  [5]="RETURN_STMT",
  [6]="INC_STMT",
  [7]="DEC_STMT",
  [8]="ASSN_STMT",
  [9]="FUNC_CALL",
  [10]="FUNC_DEF",
  [11]="IF_STMT",
  [12]="WHILE_LOOP",
  [13]="STRLIT_OUT",
  [14]="CHR_CALL",
  [15]="BIN_OP",
  [16]="UN_OP",
  [17]="NUMLIT_VAL",
  [18]="READ_CALL",
  [19]="RND_CALL",
  [20]="SIMPLE_VAR",
  [21]="ARRAY_VAR",
}


-- printAST
-- Print an AST, in (roughly) Lua form, with numbers replaced by strings
-- in symbolNames, where possible.
function printAST(...)
    if select("#", ...) ~= 1 then
        error("printAST: must pass exactly 1 argument")
    end
    local x = select(1, ...)  -- Get argument (which may be nil)

    local bracespace = ""     -- Space, if any, inside braces

    if type(x) == "nil" then
        io.write("nil")
    elseif type(x) == "number" then
        if symbolNames[x] then
            io.write(symbolNames[x])
        else
            io.write("<ERROR: Unknown constant: ", x, ">")
        end
    elseif type(x) == "string" then
        if string.sub(x, 1, 1) == '"' then
            io.write("'", x, "'")
        else
            io.write('"', x, '"')
        end
    elseif type(x) == "boolean" then
        if x then
            io.write("true")
        else
            io.write("false")
        end
    elseif type(x) ~= "table" then
        io.write('<', type(x), '>')
    else  -- type is "table"
        io.write("{", bracespace)
        local first = true  -- First iteration of loop?
        local maxk = 0
        for k, v in ipairs(x) do
            if first then
                first = false
            else
                io.write(", ")
            end
            maxk = k
            printAST(v)
        end
        for k, v in pairs(x) do
            if type(k) ~= "number"
              or k ~= math.floor(k)
              or (k < 1 and k > maxk) then
                if first then
                    first = false
                else
                    io.write(", ")
                end
                io.write("[")
                printAST(k)
                io.write("]=")
                printAST(v)
            end
        end
        if not first then
            io.write(bracespace)
        end
        io.write("}")
    end
end


-- Separator string
dashes = ("-"):rep(72)  -- Lots of dashes
equals = ("="):rep(72)  -- Lots of dashes


-- check
-- Given a "program", check its syntactic correctness using parseit.
-- Print results.
function check(program)
    io.write("Program: ", program, "\n")

    -- Parse
    local good, done, ast = parseit.parse(program)
    assert(type(good) == "boolean",
           "Function 'parse' must return 2 boolean values")
    assert(type(done) == "boolean",
           "Function 'parse' must return 2 boolean values")
    if good then
        assert(type(ast) == "table",
           "AST returned by function 'parse' must be a table")
    end

    -- Print results
    if good and done then
        io.write("Good! - AST: ")
        printAST(ast)
        io.write("\n")
    elseif good and not done then
        io.write("BAD - extra characters at end\n")
    elseif not good and done then
        io.write("UNFINISHED - more is needed\n")
    else  -- not good and not done
        io.write("BAD - syntax error\n")
    end
end


-- Main program
-- Check several "programs".
io.write("Recursive-Descent Parser: Fulmar\n")
io.write("\n")

io.write(equals, "\n")
io.write("### The following 6 programs will parse correcly with\n")
io.write("### parseit.lua as posted in the Git repository.\n")
io.write(dashes, "\n")
check("")
io.write(dashes, "\n")
check("print();")
io.write(dashes, "\n")
check("println('Yo!');")
io.write(dashes, "\n")
check("print('abc','def');print('xyz');println();")
io.write(dashes, "\n")
check("func f(){}")
io.write(dashes, "\n")
check("func g(){func h(){} println();println();}println('y');")
io.write(equals, "\n")
io.write("\n")

io.write(equals, "\n")
io.write("### The following 6 programs parse correcly.\n")
io.write("### However, parseit.lua from the Git repository may give")
io.write(" incorrect results.\n")
io.write(dashes, "\n")
check("a=3;")
io.write(dashes, "\n")
check("a=a+1;")
io.write(dashes, "\n")
check("a=readint();")
io.write(dashes, "\n")
check("print(a+1);")
io.write(dashes, "\n")
check("a=3;println(a+b);")
io.write(dashes, "\n")
check("a[e*2+1]=2;")
io.write(equals, "\n")
io.write("\n")

io.write(equals, "\n")
io.write("### The program below must have the AST from")
io.write(" the Assignment 4 description.\n")
io.write(dashes, "\n")
check("# Tamandua Example #1\n# Glenn G. Chappell\n"..
      "# 2026-01-10\nnn = 3;\nprintln(nn+4);\n")
io.write(equals, "\n")
io.write("\n")

io.write(equals, "\n")
io.write("### The program below must get the result:")
io.write(" \"BAD - extra characters at end\"\n")
io.write(dashes, "\n")
check("println();elsif")
io.write(equals, "\n")
io.write("\n")

io.write(equals, "\n")
io.write("### The program below must get the result:")
io.write(" \"UNFINISHED - more is needed\"\n")
io.write(dashes, "\n")
check("func foo(){println(")
io.write(equals, "\n")
io.write("\n")

io.write(equals, "\n")
io.write("### The program below must get the result:")
io.write(" \"BAD - syntax error\"\n")
io.write(dashes, "\n")
check("if a){ b")
io.write(equals, "\n")


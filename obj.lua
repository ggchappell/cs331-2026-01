#!/usr/bin/env lua
-- obj.lua  UNFINISHED
-- Glenn G. Chappell
-- 2026-01-29
--
-- For CS 331 Spring 2026
-- Code from Jan 30 - Lua: Objects


-- ***** Operator Overloading *****


io.write("\n*** Operator Overloading:\n")

-- We demonstrate Lua's operator overloading using tables that hold a
-- number in the value associated with key "n".

-- Here is our metatable, which defines the binary "+" and "*"
-- operators. The special function names are "__add" and "__mul".

opmt = {}  -- "opmt" = OPerator MetaTable

function opmt.__add(t1, t2)
    local t3 = {}
    setmetatable(t3, opmt)
    t3.n = t1.n + t2.n
    return t3
end

function opmt.__mul(t1, t2)
    local t3 = {}
    setmetatable(t3, opmt)
    t3.n = t1.n * t2.n
    return t3
end

-- Now we make two tables with the above as their metatable and use the
-- overloaded "+" and "*" operators.

-- Numbers that we will operate on:
num_a = 3
num_b = 5
num_c = 4

ta = { ["n"]=num_a }
setmetatable(ta, opmt)
tb = { ["n"]=num_b }
setmetatable(tb, opmt)
tc = { ["n"]=num_c }
setmetatable(tc, opmt)

-- The above would be simpler if we made a "constructor".

td = ta + tb * tc  -- Use overloaded "+" and "*" operators

io.write("Using overloaded \"+\" and \"*\" operators:\n  ")
io.write(ta.n, " + ", tb.n, " * ", tc.n, " = ", td.n, "\n")


#!/usr/bin/env lua
-- check_lua.lua
-- Glenn G. Chappell
-- 2026-01-21
--
-- For CS 331 Spring 2026
-- A Lua Program to Run
-- Used in Assignment 1, Exercise A


-- A mysterious table
tt = {[=[HJ]=],"YZTL",[2*3]='U[CS'..[==[TPUJ]==],[2+2]='JWKUK',
      [2+[[3]]]=[=[_]=]..'T'..[====[WY]====],[3]=[[ZT]]}


-- And a mysterious function
function ff(z)
    local k,x,r=13,32,63
    k = k-r - x x = x - r-k r=[===[]===]
    for y = 1,z:len() do
        r = r..string.char(string.byte(z,y)-(x%9))
        k, x = x, k+x
    end
    return r
end


-- Formatted output using the function and the table entries
io.write("Secret Message #1:\n\n")
io.write(string.format([[%s %]]..[==[s %s %s %]==]..'s %s\n',
         ff(tt[1]),ff(tt[2]),ff(tt[3]),ff(tt[4]),ff(tt[5]),ff(tt[6])))

io.write("\n")
-- Uncomment the following to wait for the user before quitting
--io.write("Press ENTER to quit ")
--io.read("*l")


-- interpit.lua  SKELETON
-- Glenn G. Chappell
-- 2026-04-06
--
-- For CS 331 Spring 2026
-- Interpret AST from parseit.parse
-- Solution to Assignment 6, Exercise A


-- *** To run a Tamandua program, use tamandua.lua (calls this file).


-- *********************************************************************
-- Module Table Initialization
-- *********************************************************************


local interpit = {}  -- Our module


-- *********************************************************************
-- Symbolic Constants for AST
-- *********************************************************************


local PROGRAM      = 1
local EMPTY_STMT   = 2
local PRINT_STMT   = 3
local PRINTLN_STMT = 4
local RETURN_STMT  = 5
local INC_STMT     = 6
local DEC_STMT     = 7
local ASSN_STMT    = 8
local FUNC_CALL    = 9
local FUNC_DEF     = 10
local IF_STMT      = 11
local WHILE_LOOP   = 12
local STRLIT_OUT   = 13
local CHR_CALL     = 14
local BIN_OP       = 15
local UN_OP        = 16
local NUMLIT_VAL   = 17
local READ_CALL    = 18
local RND_CALL     = 19
local SIMPLE_VAR   = 20
local ARRAY_VAR    = 21


-- *********************************************************************
-- Utility Functions
-- *********************************************************************


-- numToInt
-- Given a number, return the number rounded toward zero.
local function numToInt(n)
    assert(type(n) == "number")

    if n >= 0 then
        return math.floor(n)
    else
        return math.ceil(n)
    end
end


-- strToNum
-- Given a string, attempt to interpret it as an integer. If this
-- succeeds, return the integer. Otherwise, return 0.
local function strToNum(s)
    assert(type(s) == "string")

    -- Try to do string -> number conversion; make protected call
    -- (pcall), so we can handle errors.
    local success, value = pcall(function() return tonumber(s) end)

    -- Return integer value, or 0 on error.
    if success and value ~= nil then
        return numToInt(value)
    else
        return 0
    end
end


-- numToStr
-- Given a number, return its string form.
local function numToStr(n)
    assert(type(n) == "number")

    return tostring(n)
end


-- boolToInt
-- Given a boolean, return 1 if it is true, 0 if it is false.
local function boolToInt(b)
    assert(type(b) == "boolean")

    if b then
        return 1
    else
        return 0
    end
end


-- String forms of symbolic constants
-- Used by astToStr
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


-- astToStr
-- Given an AST, produce a string holding the AST in (roughly) Lua form,
-- with numbers replaced by names of symbolic constants used in parseit.
-- A table is assumed to represent an array.
-- See the Assignment 4 description for the AST Specification.
--
-- THIS FUNCTION IS INTENDED FOR USE IN DEBUGGING ONLY!
-- IT MUST NOT BE CALLED IN THE FINAL VERSION OF THE CODE.
function astToStr(...)
    if select("#", ...) ~= 1 then
        error("astToStr: must pass exactly 1 argument")
    end
    local x = select(1, ...)  -- Get argument (which may be nil)

    local bracespace = ""     -- Space, if any, inside braces

    if type(x) == "nil" then
        return "nil"
    elseif type(x) == "number" then
        if symbolNames[x] then
            return symbolNames[x]
        else
            return "<ERROR: Unknown constant: "..x..">"
        end
    elseif type(x) == "string" then
        return string.format("%q", x)
    elseif type(x) == "boolean" then
        if x then
            return "true"
        else
            return "false"
        end
    elseif type(x) ~= "table" then
        return '<'..type(x)..'>'
    else  -- type is "table"
        local result = "{"..bracespace
        local first = true  -- First iteration of loop?
        local maxk = 0
        for k, v in ipairs(x) do
            if first then
                first = false
            else
                result = result .. ", "
            end
            maxk = k
            result = result .. astToStr(v)
        end
        for k, v in pairs(x) do
            if type(k) ~= "number"
              or k ~= math.floor(k)
              or (k < 1 and k > maxk) then
                if first then
                    first = false
                else
                    result = result .. ", "
                end
                result = result .. "["
                                .. astToStr(k)
                                .. "]="
                                .. astToStr(v)
            end
        end
        if not first then
            result = result .. bracespace
        end
        result = result .. "}"

        return result
    end
end


-- *********************************************************************
-- Primary Function for Client Code
-- *********************************************************************


-- interp
-- Interpreter, given AST returned by parseit.parse.
-- Parameters:
--   ast    - AST constructed by parseit.parse
--   state  - Table holding Tamandua variables & functions
--            - AST for function xyz is in state.f["xyz"]
--            - Value of simple variable xyz is in state.v["xyz"]
--            - Value of array item xyz[42] is in state.a["xyz"][42]
--   util   - Table with 3 members, all functions:
--            - util.input() inputs line, returns string with no newline
--            - util.output(str) outputs str with no added newline
--              To print a newline, do util.output("\n")
--            - util.random(n), for an integer n, returns a pseudorandom
--              integer from 0 to n-1, or 0 if n < 2.
-- Return Value:
--   state, updated with changed variable values
function interpit.interp(ast, state, util)
    -- Each local interpretation function is given the AST for the
    -- portion of the code it is interpreting. The function-wide
    -- versions of state and until may be used. The function-wide
    -- version of state may be modified as appropriate.


    -- Forward declare local functions
    local interp_program
    local interp_stmt
    local eval_print_arg
    local eval_expr


    -- interp_program
    -- Given the ast for a program, execute it.
    function interp_program(ast)
        assert(type(ast) == "table")
        assert(#ast >= 1)
        assert(ast[1] == PROGRAM)

        for i = 2, #ast do
            interp_stmt(ast[i])
        end
    end


    -- interp_stmt
    -- Given the ast for a statement, execute it.
    function interp_stmt(ast)
        local str, funcname, funcbody

        assert(type(ast) == "table")
        assert(#ast >= 1)

        if ast[1] == EMPTY_STMT then
            assert(#ast == 1)
            return
        elseif ast[1] == PRINT_STMT or ast[1] == PRINTLN_STMT then
            for i = 2, #ast do
                str = eval_print_arg(ast[i])
                util.output(str)
            end
            if ast[1] == PRINTLN_STMT then
                util.output("\n")
            end
        elseif ast[1] == FUNC_DEF then
            assert(#ast == 3)
            funcname = ast[2]
            funcbody = ast[3]
            state.f[funcname] = funcbody
        elseif ast[1] == FUNC_CALL then
            assert(#ast == 2)
            funcname = ast[2]
            funcbody = state.f[funcname]
            if funcbody == nil then
                funcbody = { PROGRAM }
            end
            interp_program(funcbody)
        else
            print("*** UNIMPLEMENTED STATEMENT")
        end
    end


    -- eval_print_arg
    -- Given the AST for a print argument, evaluate it and return the
    -- value, as a string.
    function eval_print_arg(ast)
        local result, str, val

        assert(type(ast) == "table")
        assert(#ast >= 1)

        if ast[1] == STRLIT_OUT then
            assert(#ast == 2)
            str = ast[2]
            result = str:sub(2, str:len()-1)
        elseif ast[1] == CHR_CALL then
            assert(#ast == 2)
            print("*** UNIMPLEMENTED PRINT ARG")
            result = "ZZZZZ"  -- DUMMY VALUE
        else  -- Expression
            val = eval_expr(ast)
            result = numToStr(val)
        end

        assert(type(result) == "string")
        return result
    end


    -- eval_expr
    -- Given the AST for an expression, evaluate it and return the
    -- value, as a number.
    function eval_expr(ast)
        local result

        assert(type(ast) == "table")
        assert(#ast >= 1)

        if ast[1] == NUMLIT_VAL then
            assert(#ast == 2)
            result = strToNum(ast[2])
        else
            print("*** UNIMPLEMENTED EXPRESSION")
            result = 999999999  -- DUMMY VALUE
        end

        assert(type(result) == "number")
        return result
    end


    -- Body of function interp
    interp_program(ast)
    return state
end


-- *********************************************************************
-- Module Table Return
-- *********************************************************************


return interpit


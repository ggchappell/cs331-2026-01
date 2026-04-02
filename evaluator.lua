-- evaluator.lua  UNFINISHED
-- Glenn G. Chappell
-- 2026-04-02
--
-- For CS 331 Spring 2026
-- Evaluator for Arithmetic Expression AST (rdparser3.lua format)
-- See calculator.lua for a sample main program.


local evaluator = {}  -- Our module


-- Symbolic Constants for AST

local BIN_OP     = 1
local NUMLIT_VAL = 2
local SIMPLE_VAR = 3


-- Primary Function

-- evaluator.eval
-- Takes AST for an expression, in format specified in rdparser3.lua,
-- and table holding values of variables. Returns numeric value of
-- expression.
--
-- Example of a simple tree-walk interpreter.
function evaluator.eval(ast, vars)
    return 42  -- DUMMY
    -- TODO: WRITE THIS!!!
end


-- Module Export

return evaluator


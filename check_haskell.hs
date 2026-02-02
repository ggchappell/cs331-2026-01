-- check_haskell.hs
-- Glenn G. Chappell
-- 2026-02-02
--
-- For CS 331 Spring 2026
-- A Haskell Program to Run
-- Used in Assignment 2, Exercise A

module Main where


-- main
-- Print second secret message.
main = do
    putStrLn "Secret message #2:"
    putStrLn ""
    putStrLn secret_message
    putStrLn ""


-- secret_message
-- A mysterious message.
secret_message = map xk xj  where
    xa = [82,18,-5,-71,43,18,4,0]
    xb = [-8,-69,53,22,1,-16,13,-85]
    xc = [63,15,-15,-71,49,28,2,-18]
    xd = [-6,10,-6,8,-13,-74,45,34]
    xe = [-2,-12,-5,10,-19,4,-4]
    xf = [2,-13,17,31,-14,6,18]
    xg = "The treasure is buried under a palm tree on the third island."
    xh = map (+ xl) $ concat [xa, xb, xc, xd, xe]
    xi a as = a : map (+ a) as
    xj = foldr xi [] xh
    xk a = toEnum a `asTypeOf` hh where (hh:tt) = xg
    xl = hh where (hh:tt) = xf


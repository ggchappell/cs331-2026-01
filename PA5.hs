-- PA5.hs  SKELETON
-- Glenn G. Chappell
-- 2026-03-17
--
-- For CS 331 Spring 2026
-- Solutions to Assignment 5 Exercise B

module PA5 where


-- =====================================================================


-- collatzCounts
collatzCounts :: [Integer]
collatzCounts = [42..]  -- DUMMY; REWRITE THIS!!!


-- =====================================================================


-- operator #<
(#<) :: Ord a => [a] -> [a] -> Int
_ #< _ = 42  -- DUMMY; REWRITE THIS!!!


-- =====================================================================


-- filterOther
filterOther :: (a -> Bool) -> [a] -> [b] -> [b]
filterOther _ _ bs = bs  -- DUMMY; REWRITE THIS!!!


-- =====================================================================


-- sublist
sublist :: Eq a => [a] -> [a] -> Maybe Int
sublist _ _ = Just 42  -- DUMMY; REWRITE THIS!!!


-- =====================================================================


-- concatAlternate
concatAlternate :: [String] -> (String, String)
{-
  The assignment requires concatAlternate to be written as a fold.
  Like this:

    concatAlternate xs = fold* ... xs  where
        ...

  Above, "..." should be replaced by other code. "fold*" must be one of
  the following: foldl, foldr, foldl1, foldr1.
-}
concatAlternate _ = ("Yo", "Yoyo")  -- DUMMY; REWRITE THIS!!!


------------------------------------------------------------------------------
--
--	Haskell: The Craft of Functional Programming, 3e
--	Simon Thompson
--	(c) Addison-Wesley, 1996-2011.
--
--	Chapter 3
--
------------------------------------------------------------------------------

module Chapter3 where

import Prelude hiding (max)
import Test.QuickCheck 

-- The import statement which follows hides certain of the Prelude functions
-- so that they can be given the definitions they have in their book.


-- The Booleans.
-- ^^^^^^^^^^^^^

-- Exclusive or: this gives the result True if one of its arguments is True and
-- the other False, and gives the result False in other cases.

exOr :: Bool -> Bool -> Bool
exOr x y = (x || y) && not (x && y)

-- Using literals instead of variables in a definition; a simple example of
-- pattern matching to give another definition of `not', ...

myNot :: Bool -> Bool
myNot True  = False
myNot False = True

prop_myNot :: Bool -> Bool

prop_myNot x =
    not x == myNot x

-- ... and of `exclusive or'.

exOr1 True  x = not x
exOr1 False x = x
 
-- Test exOrs

prop_exOrs :: Bool -> Bool -> Bool

prop_exOrs x y =
    exOr x y == exOr1 x y

prop_exOr2 :: Bool -> Bool -> Bool

prop_exOr2 x y =
    exOr x y == (x /= y)

-- Exercise 3.1
exOr2 :: Bool -> Bool -> Bool
exOr2 x y = (x && not y) || (not x && y)

-- Exercise 3.2
{-
  Truth table for the exOr2 function

  t1    | t2    | t1 exOr2 t2
  -------------------------
  True  | False | True
  True  | True  | False
  False | False | False
  False | True  | True
-}

-- Exercise 3.3
exOr3 :: Bool -> Bool -> Bool
exOr3 True False  = True
exOr3 True True   = False
exOr3 False False = False
exOr3 False True  = True

-- Exercise 3.4
myAnd :: Bool -> Bool -> Bool
True `myAnd` True = True
_ `myAnd` _ = False

myOr :: Bool -> Bool -> Bool
False `myOr` False = False
_ `myOr` _ = True

-- Exercise 3.5
nAnd :: Bool -> Bool -> Bool
nAnd x y = not (x && y)

nAnd1 :: Bool -> Bool -> Bool
nAnd1 True True = False
nAnd1 _ _ = True

-- Exercise 3.6
{-
  nAnd True True
  not (True && True)
  not (True)
  False

  nAnd True False
  not (True && False)
  not (False)
  True
-}

-- Exercise 3.7
prop_exOr3 :: Bool -> Bool -> Bool
prop_exOr3 x y = 
  exOr3 x y == exOr x y

prop_myAnd :: Bool -> Bool -> Bool
prop_myAnd x y =
  myAnd x y == (x && y)

prop_myOr :: Bool -> Bool -> Bool
prop_myOr x y =
  myOr x y == (x || y)

prop_nAnd :: Bool -> Bool -> Bool
prop_nAnd x y =
  nAnd x y == nAnd1 x y

prop_nAnd1 :: Bool -> Bool -> Bool
prop_nAnd1 x y =
  nAnd1 x y == not (x && y)

-- Integers and guards.
-- ^^^^^^^^^^^^^^^^^^^^

-- A to test whether three Ints are equal.

threeEqual :: Integer -> Integer -> Integer -> Bool
threeEqual m n p = (m==n) && (n==p)

-- The maximum of two integers; this is already defined in the Prelude, 
-- so its definition is hidden by the import statement at the top of this file.

max :: Integer -> Integer -> Integer
max x y
  | x >= y      = x
  | otherwise   = y

-- The maximum of three integers.

maxThree :: Integer -> Integer -> Integer -> Integer
maxThree x y z
  | (x >= y) && (x >= z)    = x
  | y >= z                  = y
  | otherwise               = z

-- An alternative definition of max which uses if ... then ... else ...

max' :: Integer -> Integer -> Integer
max' x y
  = if x >= y then x else y

prop_compareMax :: Integer -> Integer -> Bool
prop_compareMax x y =
    max x y == max' x y

prop_max1, prop_max2, prop_max3 :: Integer -> Integer -> Bool

prop_max1 x y =
    x <= max x y && y <= max x y

prop_max2 x y =
    x == max x y || y == max x y

prop_max3 x y =
    (x == max x y) `exOr` (y == max x y)

-- Exercise 3.8
mystery :: Integer -> Integer -> Integer -> Bool
mystery m n p = not ((m==n) && (n==p))
-- The purpose of this function is the inverse of threeEqual

-- Exercise 3.9
threeDifferent :: Integer -> Integer -> Integer -> Bool
threeDifferent m n p = (m/=n) && (m/=p) && (n/=p)
-- threeDifferent 3 4 3 equals False due to the fact that the conditions (m/=n) and (n/=p) are False

-- Exercise 3.10
fourEqual :: Integer -> Integer -> Integer -> Integer -> Bool
fourEqual m n p q = (m==n) && (m==p) && (m==q) && (n==p) && (n==q) && (p==q)

fourEqual1 :: Integer -> Integer -> Integer -> Integer -> Bool
fourEqual1 m n p q = threeEqual m n p && (p==q)

-- Characters.
-- ^^^^^^^^^^^

-- Converting lower-case letters to upper-case; does something odd if you apply
-- it to anythig else: how would you modify it to return anything else
-- unchanged?
 
toUpper :: Char -> Char
toUpper ch = toEnum (fromEnum ch + offset)

offset = fromEnum 'A' - fromEnum 'a'

-- A check whether a character is a digit.

isDigit :: Char -> Bool
isDigit ch = ('0' <= ch) && (ch <= '9')


-- The String type
-- ^^^^^^^^^^^^^^^

-- Example strings

str1, str2, str3, str4, str5 :: String

str1 = "baboon"
str2 = ""
str3 = "\99a\116"
str4 = "gorilla\nhippo\nibex"
str5 = "1\t23\t456"

pstr1, pstr2, pstr3, pstr4, pstr5 :: IO ()

pstr1 = putStr str1
pstr2 = putStr str2
pstr3 = putStr str3
pstr4 = putStr str4
pstr5 = putStr str5



-- Some syntax.
-- ^^^^^^^^^^^^

-- Layout: two definitions on one line, separated by a `;'.

answer = 42 ;   facSix = 720 

-- Adding two integers: you can use longer names for variables than x and y!

addTwo :: Integer -> Integer -> Integer
addTwo first second = first+second

-- Defining an operator for yourself: another version of max!

(&&&) :: Integer -> Integer -> Integer
x &&& y 
  | x > y       = y
  | otherwise   = x

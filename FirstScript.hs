{- #########################################################

        FirstScript.hs
        Simon Thompson, August 2010.

######################################################### -}

module FirstScript where

--      The value size is an integer (Integer), defined to be 
--      the sum of twelve and thirteen.

size :: Integer
size = 12+13

--      The function to square an integer.

square :: Integer -> Integer
square n = n*n

--      The function to double an integer.
        
double :: Integer -> Integer
double n = 2*n

--      An example using double, square and size.
         
example :: Integer
example = double (size - square (2+2))

--      The function should double its input and square the result of that

square_double :: Integer -> Integer
square_double n = square (double n)

--      The function should square its input and double the result of that

double_square :: Integer -> Integer
double_square n = double (square n)
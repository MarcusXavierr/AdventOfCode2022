import System.IO
import Control.Monad

convertLetterToShape :: String -> Int
convertLetterToShape "A" = 0
convertLetterToShape "B" = 1
convertLetterToShape "C" = 2
convertLetterToShape "X" = 0
convertLetterToShape "Y" = 1
convertLetterToShape "Z" = 2
convertLetterToShape _ = error "shape doesn't exists"

toTuple :: [a] -> (a, a)
toTuple [a,b] = (a,b)
toTuple _ = error "wrong input"

mapTuple :: (a -> b) -> (a, a) -> (b, b)
mapTuple f (a1, a2) = (f a1, f a2)

getRounds :: String -> [(String,String)]
getRounds = map (toTuple . words) . lines

getShapes :: [(String, String)] -> [(Int, Int)]
getShapes = map (mapTuple convertLetterToShape)

createRound :: (Int, Int) -> (Int, Int)
createRound (f,s)
    | s == 0 = (f, circularDecrement f)
    | s == 1 = (f, f)
    | otherwise = (f, circularIncrement f)

getResult :: (Int, Int) -> Int
getResult (a, b)
 | circularDecrement b == a = 6
 | b == a = 3
 | otherwise = 0

convertShapeToScore :: [(Int, Int)] -> [Int]
convertShapeToScore = map (\x -> (snd x + 1) + getResult x)

circularOperation :: Integral a => (a -> a) -> a -> a
circularOperation f x = ((f x `mod` 3) + 3) `mod` 3

circularIncrement :: Integral a => a -> a
circularIncrement = circularOperation (+ 1)

circularDecrement :: Integral a => a -> a
circularDecrement = circularOperation (\x -> x - 1)

main :: IO ()
main = do
   handle <- openFile "./data" ReadMode
   content <- hGetContents handle
   (print . sum . convertShapeToScore . map createRound . getShapes . getRounds) content
   hClose handle

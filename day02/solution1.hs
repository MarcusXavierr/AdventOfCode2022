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

getResult :: (Int, Int) -> Int
getResult (a, b)
 | circularSubtraction b == a = 6
 | b == a = 3
 | otherwise = 0

getScores :: String -> [Int]
getScores = convertShapeToScore . getShapes . getRounds

convertShapeToScore :: [(Int, Int)] -> [Int]
convertShapeToScore = map (\x -> (snd x + 1) + getResult x)

circularSubtraction :: Integral a => a -> a
circularSubtraction x = (((x - 1) `mod` 3) + 3) `mod` 3

main :: IO ()
main = do
   handle <- openFile "./data" ReadMode
   content <- hGetContents handle
   (print . sum . getScores) content
   hClose handle

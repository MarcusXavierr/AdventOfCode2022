import System.IO
import Control.Monad

divideRucksack :: String -> (String, String)
divideRucksack xs = result
    where
        middleIndex = length xs `div` 2
        result = splitAt middleIndex xs

mutuals :: Eq a => [a] -> [a] -> [a]
mutuals [] _ = []
mutuals (x:xs) ys
    | x `elem` ys = x: mutuals xs (filter (/= x) ys)
    | otherwise = mutuals xs ys

convertEnumToPriority :: Int -> Int
convertEnumToPriority x
    | x >= 65 && x <= 90 = x - 38
    | x >= 97 && x <= 122 = x - 96
    | otherwise = error "invalid number"

getPriority :: String -> Int
getPriority [] = error "could not be empty"
getPriority (x:_) = (convertEnumToPriority . fromEnum) x

getDividedRucksacks :: String -> [(String, String)]
getDividedRucksacks = map divideRucksack . lines

getMutuals :: (String, String) -> String
getMutuals (fs,sn) = mutuals fs sn

main :: IO ()
main = do
   handle <- openFile "./data" ReadMode
   content <- hGetContents handle
   let transformedRucksacks = map (getPriority . getMutuals) $ getDividedRucksacks content
   print $ sum transformedRucksacks
   hClose handle

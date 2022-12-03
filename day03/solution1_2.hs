import System.IO
import Control.Monad

groupRucksacks :: Int -> Int -> [a] -> [[a]]
groupRucksacks _ _ [] = []
groupRucksacks index maxSize rucksacks
    | index == maxSize - 1 = take maxSize rucksacks : groupRucksacks 0 maxSize (drop maxSize rucksacks)
    | otherwise = groupRucksacks (index + 1) maxSize rucksacks

getBadge :: [String] -> String
getBadge = foldl1 mutuals

mutuals :: Eq a => [a] -> [a] -> [a]
mutuals [] _ = []
mutuals (x:xs) ys
    | x `elem` ys = x: mutuals xs (filter (/= x) ys)
    | otherwise = mutuals xs ys

getPriority :: String -> Int
getPriority [] = error "could not be empty"
getPriority (x:_) = (convertEnumToPriority . fromEnum) x

convertEnumToPriority :: Int -> Int
convertEnumToPriority x
    | x >= 65 && x <= 90 = x - 38
    | x >= 97 && x <= 122 = x - 96
    | otherwise = error "invalid number"

main :: IO ()
main = do
   handle <- openFile "./data" ReadMode
   content <- hGetContents handle
   let groupedRucksacks = (groupRucksacks 0 3 . lines) content
       transformedGroups = map (getPriority . getBadge) groupedRucksacks
   print $ sum transformedGroups
   hClose handle

import System.IO
import Control.Monad
import Text.Read (readMaybe)
import Data.Maybe (fromJust)

group' :: Eq a => (a -> Bool) -> [a] -> [[a]]
group' _ [] = []
group' f xs = takeWhile f xs : group' f ((safeTail . dropWhile f) xs)

safeTail :: [a] -> [a]
safeTail [] = []
safeTail (x:xs) = xs

readMaybeInt :: String -> Maybe Int
readMaybeInt = readMaybe

maybee :: [String] -> Maybe Int
maybee = fmap sum . sequence . map readMaybeInt

mapJust :: String -> [Maybe Int]
mapJust = map maybee . group' (/= "") . lines

main :: IO ()
main = do
   handle <- openFile "./data" ReadMode
   content <- hGetContents handle
   let max = maximum $ mapJust content
   print $ fromJust max
   hClose handle

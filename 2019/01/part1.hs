import System.IO (readFile)
import Data.String (lines)

fuelCounter :: Int -> Int
fuelCounter mass = quot mass 3 - 2

massesToFuel :: [Int] -> Int
massesToFuel = foldl calc 0
    where calc acc x = acc + fuelCounter x
    
main :: IO ()
main = do
    masses <- readFile "data.txt"
    print (massesToFuel (map read (lines masses) :: [Int]))
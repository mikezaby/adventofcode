import System.IO (readFile)
import Data.String (lines)

fuelCounter :: Int -> Int -> Int
fuelCounter mass totalFuel = 
    let fuel = quot mass 3 - 2
    in if fuel <= 0 then totalFuel else fuelCounter fuel (totalFuel + fuel0)

massesToFuel :: [Int] -> Int
massesToFuel = foldl calc 0
    where calc acc x = acc + fuelCounter x 0
    
main :: IO ()
main = do
    masses <- readFile "data.txt"
    print (massesToFuel (map read (lines masses) :: [Int]))
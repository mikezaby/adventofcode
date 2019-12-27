import Data.List.Split (splitOn)
import Control.Lens
import Debug.Trace (trace)

executeProgram :: ([Int], Int) -> [Int]
executeProgram (program, -1) = program
executeProgram (program, index) = executeProgram (executeOpcode (program, index))

executeOpcode :: ([Int], Int) -> ([Int], Int)
executeOpcode (program, index) = 
    let opcode = program !! index
    in if opcode == 99 
        then (program, -1) 
        else (transProgram (program, opcode, index + 1), index + 4) 

transProgram :: ([Int], Int, Int) -> [Int]
transProgram (program, opcode, index) = 
    let val1 = program !! (program !! index)
        val2 = program !! (program !! (index + 1))
        storeIndex = program !! (index + 2)
        operator = if opcode == 1 then (+) else (*)
    in program & element storeIndex .~ operator val1 val2

main :: IO ()
main = do
    opcodes <- readFile "data.txt"
    print (head (executeProgram (map read (splitOn "," opcodes) :: [Int], 0)))
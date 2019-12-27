import Data.List.Split (splitOn)
import Control.Lens

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
    in arraySet (program, storeIndex, operator val1 val2)

arraySet :: ([Int], Int, Int) -> [Int]
arraySet (arr, index, value) = arr & element index .~ value

nounVerbFinder :: ([Int], Int) -> Int
nounVerbFinder (program, counter) =
    let noun = quot counter 100
        verb = mod counter 100
    in let addr0 = head (executeProgram (newProgram (program, noun, verb), 0))
       in if addr0 == 19690720 
          then 100 * noun + verb
          else nounVerbFinder(program, counter + 1)

newProgram :: ([Int], Int, Int) -> [Int]
newProgram (program, noun, verb) = arraySet (arraySet (program, 1, noun), 2, verb)

main :: IO ()
main = do
    opcodes <- readFile "data.txt"
    print (nounVerbFinder (map read (splitOn "," opcodes) :: [Int], 0))
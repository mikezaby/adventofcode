# adventofcode
My solutions of http://adventofcode.com/

## 2020
Require ruby 2.7 (not tested to other versions)

### Install
Install dependencies
`bundle install`

### Run advent day
We need to have specific file structure to find the advents of its day
```
- 2020
  - 01
    - part1.rb
    - part2.rb
    - data.txt
```
Now we can run our code.
Run command `advent` inside the root of the project
This opens an irb with the enviroment loaded.

Inside the `irb` run the following command
`run`
This command execute the current day and the part1
If you want to run specific part
`run 1` 
or 
`run 2`
If tou want to run specific day and part
`run 2, Date.yesterday`

use std::collections::HashMap;
use std::io::BufReader;
use std::io::prelude::*;
use std::fs::File;

pub struct Cpu {
    pc: i32,
    pub registers: HashMap<String, usize>,
    program: Vec<String>
}


impl Cpu {
    pub fn new() -> Cpu {
        let mut cpu = Cpu {
            pc: 0,
            registers: HashMap::new(),
            program: vec![]
        };

        cpu.registers.insert("a".to_string(), 1);
        cpu.registers.insert("b".to_string(), 0);

        cpu
    }

    pub fn load_program(&mut self) {
        let file = File::open("input.txt").unwrap();
        let file = BufReader::new(file);
        for line in file.lines() {
            self.program.push(line.unwrap());
        }
    }

    pub fn run(&mut self) {
        self.execute_instruction();
        self.pc += 1;
        println!("pc: {}", self.pc);
        if self.pc < (self.program.len() as i32) { self.run(); }
    }

    fn execute_instruction(&mut self) {
        let mut instruction: Vec<&str> = self.program[self.pc as usize].split(' ').collect();
        instruction[1] = instruction[1].trim_matches(',');

        match instruction[0] {
            "hlf" => *self.registers.get_mut(instruction[1]).unwrap() >>= 1,
            "tpl" => *self.registers.get_mut(instruction[1]).unwrap() *= 3,
            "inc" => *self.registers.get_mut(instruction[1]).unwrap() += 1,
            "jmp" => self.pc += instruction[1].parse::<i32>().unwrap() - 1,
            "jie" => {
                if self.registers[instruction[1]] % 2 == 0 {
                    self.pc += instruction[2].parse::<i32>().unwrap() - 1
                }
            },
            "jio" => {
                if self.registers[instruction[1]] == 1 {
                    self.pc += instruction[2].parse::<i32>().unwrap() - 1
                }
            },
            _     => println!("not implemented")
        }
    }
}

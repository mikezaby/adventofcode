mod cpu;

use cpu::Cpu;

fn main() {
    let mut cpu = Cpu::new();
    cpu.load_program();
    cpu.run();
    println!("b: {}", cpu.registers["b"]);
    println!("a: {}", cpu.registers["a"])
}

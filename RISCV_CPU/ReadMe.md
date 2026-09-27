                   #  3 Staage 32 bit RiscV CPU with test bench to test in ModelSim #
                   
# Architecture included in this processor #
- 32-bit RISC-V processor
- RV32I subset
- 3-stage pipeline
- Separate instruction and data memory
- Forwarding
- Load-use hazard stall
- Branch flush
- No branch prediction
- LW and SW support
- JAL support

# Pipeline Architecture #
IF → ID/EX → MEM/WB

# Program #
Verilog

# Tools #
ModelSim

# Folder Structure #
RISC-V-CPU/
│
├── program/
│   └── sample_program_1.hex
|
├── rtl/
│   ├── BranchUnit.v
│   ├── ControlUnit.v
│   ├── DataMem.v
    │   ├── FrwdUnit.v
    │   ├── HazardUnit.v
    │   ├── ImmGen.v
    │   ├── InstDecode.v
    │   ├── InstFetch.v
    │   ├── InstMem.v
    │   ├── RegFile.v
    │   ├── alu.v
    |   ├── pc.v
    │   └── riscv32.v
    │
    ├── tb/
    │   └── riscv_cpu_tb.v
    │
    └── README.md

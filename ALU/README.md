# Parameterized ALU Design in Verilog

## Overview

This project implements a **parameterized Arithmetic Logic Unit (ALU)** using Verilog HDL. 
The ALU is designed to perform multiple arithmetic, logical, and shift operations on input data and generate corresponding output values along with status flags.

The design is modular, with separate blocks for arithmetic operations, logical operations, and bit shifting. The width of the ALU can be easily modified using parameters, allowing the same design to be used for different data sizes such as 4-bit, 8-bit, or higher.

## Project Features

- Fully parameterized ALU data width
- Modular design using separate Verilog modules
- Supports arithmetic operations:
  - Addition
  - Subtraction
  - Multiplication
  - Division
- Supports logical operations:
  - AND
  - OR
  - XOR
  - NOT
- Supports shift operations:
  - Left shift
  - Right shift
- Generates status flags:
  - Carry flag
  - Borrow flag
  - Overflow flag
  - Divide-by-zero flag
  - Zero flag

## Architecture

The ALU is divided into three main functional units:

### 1. Arithmetic Unit
Handles mathematical operations such as addition, subtraction, multiplication, and division.  
It also calculates arithmetic-related flags such as carry, borrow, overflow, and divide-by-zero conditions.

### 2. Logic Unit
Performs bitwise logical operations:
- AND
- OR
- XOR
- NOT

### 3. Shifter Unit
Handles bit manipulation operations:
- Logical left shift
- Logical right shift

The output of these units is selected based on the operation code provided to the ALU.

## Design Approach

The ALU uses a modular approach where each operation group is implemented as an independent module. 
A top-level module connects these blocks together and selects the required operation based on the opcode input.

The parameterized design allows easy scalability by changing the data width parameter without modifying the internal logic.

## Tools Used

- **Hardware Description Language:** Verilog HDL
- **Simulation:** ModelSim / Quartus Simulator
- **FPGA Development Environment:** Intel Quartus Prime
- **Target:** FPGA implementation

## Learning Outcomes

Through this project, I explored:
- RTL design methodology
- Modular hardware design
- Parameterized Verilog programming
- Combinational circuit design
- Status flag generation
- FPGA synthesis and simulation workflow

## Future Improvements

Possible improvements:
- Add multiplication optimization using dedicated hardware techniques
- Add signed arithmetic support
- Implement pipelining for higher clock frequencies
- Add more advanced operations like comparison and rotate instructions

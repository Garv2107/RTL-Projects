# Asynchronous FIFO (Verilog HDL)

## Overview

This project implements a parameterized Asynchronous FIFO (First-In First-Out) using Verilog HDL. The FIFO enables safe data transfer between two independent clock domains by using Gray code pointers and two-stage synchronizers to prevent metastability.

The design supports independent read and write operations with separate clocks, making it suitable for Clock Domain Crossing (CDC) applications in digital systems.

---

## Features

- Parameterized FIFO Design
- Independent Read and Write Clock Domains
- Separate Read and Write Enable Signals
- Gray Code Pointer Conversion
- Two-Flip-Flop Synchronizers
- Full and Empty Flag Generation
- Parameterized Data Width and FIFO Depth
- Synthesizable RTL Design

---

## Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| DATA_WIDTH | 8 | Width of each data word |
| DEPTH | 64 | Number of FIFO locations |
| ADDR_WIDTH | 6 | Address width (2^ADDR_WIDTH = DEPTH) |

---

## Ports

### Inputs

| Signal | Description |
|---------|-------------|
| wr_clk | Write Clock |
| rd_clk | Read Clock |
| rst | Asynchronous Reset |
| wr_en | Write Enable |
| rd_en | Read Enable |
| data_in | Input Data |

### Outputs

| Signal | Description |
|---------|-------------|
| data_out | Output Data |
| full | FIFO Full Flag |
| empty | FIFO Empty Flag |

---

## Architecture

The FIFO consists of the following blocks:

- Dual-Port Memory
- Binary Read Pointer
- Binary Write Pointer
- Gray Code Conversion
- Two-Stage Synchronizers
- Full Flag Logic
- Empty Flag Logic

---

## Clock Domain Crossing (CDC)

Since the read and write clocks operate independently, direct transfer of binary pointers between clock domains may lead to metastability.

To overcome this issue:

- Binary pointers are converted to Gray code.
- Gray pointers are synchronized using two-stage flip-flop synchronizers.
- The synchronized Gray pointers are used for Full and Empty detection.

This ensures reliable operation across different clock domains.

---

## Full Detection

The FIFO is considered **Full** when the write pointer is one complete cycle ahead of the read pointer.

The comparison is performed using synchronized Gray pointers.

---

## Empty Detection

The FIFO is considered **Empty** when the synchronized write Gray pointer becomes equal to the read Gray pointer.

---

## Simulation

The design was verified using a Verilog testbench with independent write and read clocks.

The testbench validates:

- Single Write
- Single Read
- Multiple Writes
- Multiple Reads
- Simultaneous Read & Write
- FIFO Full Condition
- FIFO Empty Condition
- Read While Empty
- Write While Full

---

## Tools Used

- Xilinx Vivado
- Verilog HDL
- Vivado Simulator

---

---

## Future Improvements

- SystemVerilog Testbench
- Functional Coverage
- Assertions (SVA)
- Randomized Verification
- UVM-based Verification
- Configurable Almost Full / Almost Empty Flags

---

## Author

Garv Patel

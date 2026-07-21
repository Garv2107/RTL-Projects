# Parameterized Synchronous FIFO (Verilog HDL)

## Overview

This project implements a parameterized synchronous First-In-First-Out (FIFO) memory in Verilog HDL. The FIFO operates using a single clock for both read and write operations and includes status flags to indicate empty and full conditions.

The design was verified using a self-checking testbench in ModelSim.

---

## Features

- Parameterized data width
- Parameterized FIFO depth
- Single clock (Synchronous FIFO)
- Read and Write pointers
- FIFO occupancy counter
- Empty flag
- Full flag
- Self-checking testbench

---

## Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| DATA_WIDTH | Width of each data word | 8 bits |
| DEPTH | Number of FIFO locations | 64 |
| ADDR_WIDTH | Address width (`2^ADDR_WIDTH >= DEPTH`) | 6 |

---

## Inputs

| Signal | Description |
|---------|-------------|
| clk | System clock |
| rst | Asynchronous reset |
| wr_en | Write enable |
| rd_en | Read enable |
| data_in | Input data |

---

## Outputs

| Signal | Description |
|---------|-------------|
| data_out | Output data |
| full | FIFO Full flag |
| empty | FIFO Empty flag |
| FIFO_counter | Number of stored data words |

---

## Verification

The design was verified using a custom Verilog testbench in ModelSim.

### Test Cases Performed

- Reset operation
- Single Write
- Multiple Writes
- Single Read
- Multiple Reads
- Simultaneous Read and Write
- Empty FIFO condition
- Full FIFO condition
- Read attempt when FIFO is empty
- FIFO counter verification

All test cases passed successfully.

---

## Tools Used

- Quartus Prime
- ModelSim
- Verilog HDL

---

## Project Structure

```
Synchronous_FIFO/
│
├── syn_FIFO.v          // RTL Design
├── sync_FIFO_tb.v      // Testbench

```

---

## Future Improvements

- Asynchronous FIFO implementation
- Randomized testbench
- Functional coverage
- SystemVerilog Assertions (SVA)

---

## Author

**Garv Patel**

Electronics & Communication Engineering

Interested in RTL Design, FPGA Design, and Digital VLSI.

# UART Communication Modules - Verilog HDL

## Overview

This project implements the fundamental building blocks of UART (Universal Asynchronous Receiver Transmitter) communication using Verilog HDL.

The design is divided into three independent RTL modules:

- UART Transmitter (TX)
- UART Receiver (RX)
- Baud Rate Generator

Each module is developed and verified separately to understand the working of UART communication at the hardware level.

---


---

# Modules

## 1. UART Transmitter (TX)

The UART transmitter converts parallel data into a serial bit stream according to the UART protocol.

### Working:
- Accepts 8-bit input data.
- Adds UART framing bits:
  - Start bit (Logic 0)
  - 8 Data bits (LSB first)
  - Stop bit (Logic 1)
- Transmits data serially through the TX line.

### Features:
- FSM-based control
- Serial data generation
- Busy signal indication
- Baud-rate synchronized transmission

---

## 2. UART Receiver (RX)

The UART receiver converts incoming serial data into parallel data.

### Working:
- Monitors the RX line for a start bit.
- Samples incoming bits using baud timing.
- Stores received bits into a shift register.
- Outputs the received 8-bit parallel data.
- Generates an RX done pulse after successful reception.

### Features:
- Start bit detection
- Serial-to-parallel conversion
- LSB first data reception
- Stop bit checking
- RX completion indication

---

## 3. Baud Rate Generator

The Baud Rate Generator provides timing pulses required for UART communication.

### Working:
- Divides the system clock to generate baud-rate timing.
- Provides a common timing reference for TX and RX modules.
- Ensures correct bit transmission and sampling intervals.

### Features:
- Configurable baud rate
- Parameterized clock division
- Reusable for TX and RX modules

---


UART transmits data asynchronously, meaning no separate clock line is required between transmitter and receiver.

---

# Verification

The modules were verified using Verilog testbenches.

Testing included:
- Character transmission
- Numeric data transmission
- Start bit detection
- Stop bit validation
- RX/TX timing verification
- Baud-rate synchronization

---

# Tools Used

- Verilog HDL
- Xilinx Vivado Simulator

---

# Learning Outcomes

- Understanding UART serial communication protocol
- Designing FSM-based RTL modules
- Implementing clock divider circuits
- Developing modular hardware designs
- RTL simulation and debugging

---

# Future Improvements

- Add parity bit support
- Parameterize data width
- Add FIFO buffering
- Implement full-duplex UART communication
- FPGA hardware testing


# 8-Bit ALU Design & Verification (Combinational Logic)

##  Project Overview

This repository contains a **synthesizable 8-bit Arithmetic Logic Unit (ALU)** along with a **randomized, self-checking SystemVerilog testbench**.

The project demonstrates the transition from **basic digital design** to **automated hardware verification**.  

By using a **self-checking mechanism**, the testbench automatically validates the ALU output against a **golden reference model**, eliminating the need for manual waveform inspection.

---

##  Live Demo

 **Run this project on EDA Playground**  
https://www.edaplayground.com/x/gvMu

---

##  Design Specifications

- **ALU Width**: 8-bit  
- **Logic Type**: Combinational  
- **Control**: 3-bit opcode  
- **Number of Operations**: 8  

### Opcode Table

| Opcode | Operation        |
|------:|------------------|
| 000   | Addition         |
| 001   | Subtraction      |
| 010   | Bitwise AND      |
| 011   | Bitwise OR       |
| 100   | Bitwise XOR      |
| 101   | Bitwise NOT|
| 110   | Logical Left Shift|
| 111   | Logical Right Shift |

---

##  Verification Strategy

This project follows a **Constrained Random Verification (CRV)** approach:

- **Randomized Stimulus**  
  Inputs `A` and `B` are assigned random values each cycle to cover a wide input space.

- **Golden Reference Model**  
  The testbench computes the expected output using behavioral SystemVerilog logic.

- **Automated Comparison**  
  The DUT output is compared against the reference model using an `if–else` check.

- **Error Logging**  
  Any mismatch is immediately printed to the console with full debug information (opcode, inputs, expected vs actual output).

---

##  How to Run & Visualize

### Using EDA Playground (Recommended)

1. Open the **project link** on EDA Playground  
2. Select **Icarus Verilog 12.0** from the left sidebar  
3. Enable **“Open EPWave after run”**  
4. Click **Run**

---

##  Viewing Waveforms (EPWave)

After simulation completes, the **EPWave** window will open.

To analyze results:
- Compare inputs `A` and `B` with the `result` bus  
- Verify correct operation for each opcode  
- Ensure the **error flag (if implemented)** remains LOW throughout simulation

---

##  Simulation Screenshots

Simulation waveforms and results are shown below.

> **Note:**  
> Upload your waveform screenshots to this repository and update the image path accordingly.

```md
![Simulation Waveform](images/alu_waveform.png)

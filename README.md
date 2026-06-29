# Verilog Square Root Algorithms

This project implements and compares four different methods for calculating the square root of an 8-bit unsigned number using Verilog HDL.

The objective is to study the trade-offs between hardware cost, execution speed, scalability, and implementation complexity of various square-root algorithms commonly used in digital systems.

---

# Implemented Algorithms

## 1. Binary Search Method

- Datapath + Controller based implementation
- Iteratively searches for the square root
- Uses FSM-generated control signals
- Demonstrates classical digital system design methodology

## 2. Lookup Table (LUT) Method

- Uses precomputed square-root values
- Implemented using a combinational case statement
- Produces output in a single cycle
- Suitable for small input ranges

## 3. Newton-Raphson Method

- Iterative approximation algorithm
- Fast convergence
- Uses the update equation:

```
Xnext = (X + N/X)/2
```

- Commonly used in numerical computation

## 4. Non-Restoring Square Root Method

- Digit-by-digit square root extraction
- Similar to non-restoring division
- Processes one pair of bits per iteration
- Widely used in arithmetic hardware

---

# Architecture

## Binary Search Method

Implemented using separate Datapath and Controller modules.

### Datapath Components

- LOW register
- HIGH register
- MID register
- N register
- Adder
- Divider by 2
- Comparators

### Controller

FSM generates control signals such as:

- ldLOW
- ldHIGH
- ldMID
- ldN
- low_sel
- high_sel
- done

This implementation demonstrates the separation of control path and datapath used in practical digital systems.

---

## Lookup Table (LUT)

Pure combinational implementation using a Verilog case statement.

No FSM or iterative hardware is required.

Output is generated immediately for every input.

---

## Newton-Raphson Method

Implemented using an FSM-based iterative architecture.

### States

- Load Input
- Initialize Estimate
- Compute Next Approximation
- Done

The algorithm repeatedly updates the estimate until convergence.

---

## Non-Restoring Square Root Method

Implemented using a sequential iterative architecture.

### Main Registers

- Q (Square Root)
- R (Partial Remainder)
- N_reg (Input Register)
- Iteration Counter

One pair of input bits is processed during each iteration.

---

# FPGA Implementation

All architectures were synthesized and implemented using

- **AMD Vivado Design Suite 2025.2**
- **Target FPGA:** Artix-7 (xc7a35tcpg236-1)

The following implementation flow was performed for every architecture:

- Behavioral Simulation
- RTL Synthesis
- RTL Schematic Generation
- Synthesized Schematic Inspection
- Place and Route (Implementation)
- FPGA Resource Utilization Analysis
- Timing Analysis (Clocked Architectures)

---

# Hardware Resource Comparison

| Algorithm | Slice LUTs | Slice Registers | Timing Status |
|------------|-----------:|----------------:|---------------|
| Binary Search | 104 | 42 | Meets 100 MHz Timing |
| Newton-Raphson | 117 | 26 | Timing Constraint Not Met |
| Non-Restoring | 19 | 25 | Meets 100 MHz Timing |
| Lookup Table | 6 | 0 | Not Applicable (Combinational Design) |

---

# Hardware Observations

### Binary Search

- Moderate FPGA resource utilization
- Separate datapath and controller increase register usage
- Successfully meets the 100 MHz timing constraint

### Lookup Table

- Lowest combinational hardware requirement
- Pure combinational implementation
- Timing analysis is not applicable since the design contains no clocked elements

### Newton-Raphson

- Highest LUT utilization
- Hardware divider significantly increases combinational complexity
- Does not satisfy the 100 MHz timing constraint

### Non-Restoring

- Most hardware-efficient sequential architecture
- Very low LUT utilization
- Successfully meets timing requirements

---

---

## Repository Structure

```text
Verilog_Square_Root_Algorithms
│
├── BINARY SEARCH
│   ├── datapath.v
│   ├── controller.v
│   ├── testbench.v
│   └── BINARY SEARCH.png
│
├── LOOKUP TABLE
│   ├── sr_lut.v
│   ├── sr_lut_tb.v
│   └── LOOKUP TABLE.png
│
├── NEWTON RAPHSON
│   ├── newton_raphson.v
│   ├── newton_raphson_tb.v
│   └── NEWTON RAPHSON.png
│
├── NON RESTORING
│   ├── non_restoring.v
│   ├── non_restoring_tb.v
│   └── NON RESTORING.png
│
└── README.md
```
---

# Tools Used

- Verilog HDL
- AMD Vivado Design Suite 2025.2
- Icarus Verilog
- GTKWave
- Visual Studio Code

---



---

# Sample Results

| Input N | Expected √N | Binary Search | LUT | Newton-Raphson | Non-Restoring |
|----------|------------|---------------|-----|----------------|---------------|
| 16 | 4 | 4 | 4 | 4 | 4 |
| 50 | 7 | 7 | 7 | 7 | 7 |
| 144 | 12 | 12 | 12 | 12 | 12 |
| 169 | 13 | 13 | 13 | 13 | 13 |
| 255 | 15 | 15 | 15 | 15 | 15 |

---

# Comparison of Algorithms

| Algorithm | Iterations / Cycles* | Memory Usage | Arithmetic Complexity | Scalability |
|------------|---------------------|---------------|----------------------|-------------|
| LUT | 1 | Very High | Very Low | Poor |
| Binary Search | 4–5 iterations (8-bit input) | Low | Medium | Good |
| Newton-Raphson | 4–6 iterations | Low | High (Division Required) | Excellent |
| Non-Restoring | Fixed 4 iterations (8-bit input) | Low | Medium | Excellent |

\*Approximate values observed during simulation for 8-bit inputs.

---

# Design Trade-Offs

## LUT

### Advantages

- Fastest output generation
- Very simple implementation

### Disadvantages

- Memory requirement grows rapidly with input width
- Not suitable for large inputs

---

## Binary Search

### Advantages

- Easy to understand and implement
- Good balance between speed and hardware

### Disadvantages

- Requires multiple iterations
- Execution time depends on search range

---

## Newton-Raphson

### Advantages

- Fast convergence
- Scales well for larger input sizes

### Disadvantages

- Requires division hardware
- Higher arithmetic complexity

---

## Non-Restoring

### Advantages

- Fixed execution time
- Hardware efficient
- Widely used in arithmetic circuits

### Disadvantages

- More complex than Binary Search
- Requires careful remainder management

---


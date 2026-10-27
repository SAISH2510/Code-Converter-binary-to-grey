# 8-Bit Binary ↔ Gray Code Converter Using Verilog

## 📌 Project Overview

This project implements an **8-bit Binary-to-Gray and Gray-to-Binary Code Converter** using Verilog HDL. The design uses registers, XOR-based conversion logic, a finite state machine (FSM), and a shared internal bus to perform the conversion operations.

The converter supports both conversion directions and uses control signals to select the required operation. A testbench can be used to verify the conversion functionality, while an SDC file specifies the timing constraints for synthesis and static timing analysis.

## 🎯 Objectives

* Design an 8-bit Binary-to-Gray code converter.
* Implement Gray-to-Binary conversion using XOR logic.
* Develop an FSM-based sequential architecture.
* Verify the design using a Verilog/SystemVerilog testbench.
* Define timing constraints for synthesis and static timing analysis.

## ⚙️ Features

* **8-bit Data Processing:** Supports 8-bit input and output data.
* **Bidirectional Conversion:** Supports Binary-to-Gray and Gray-to-Binary operations.
* **FSM-Based Control:** Uses a finite state machine to sequence conversion operations.
* **Register-Based Architecture:** Uses internal registers to store input and intermediate results.
* **XOR-Based Conversion:** Uses XOR logic for the conversion process.
* **Control Signals:** Uses `start`, `convert`, and `done` to manage the operation.
* **Timing Constraints:** Includes an SDC file targeting a 1 GHz clock frequency.

## 🧠 Conversion Theory

### Binary to Gray Code

The most significant bit (MSB) remains unchanged. Each remaining Gray bit is obtained by XORing two adjacent binary bits.

For an 8-bit binary input:

$$
G_7 = B_7
$$

$$
G_i = B_{i+1} \oplus B_i,\quad 0 \leq i < 7
$$

### Gray Code to Binary

The most significant binary bit remains unchanged. Each subsequent binary bit is obtained by XORing the previous binary bit with the corresponding Gray bit.

$$
B_7 = G_7
$$

$$
B_i = B_{i+1} \oplus G_i,\quad 0 \leq i < 7
$$

Here, \(\oplus\) represents the XOR operation.

## 🏗️ Design Architecture

The design uses the following components:

* **Input Registers:** Store the incoming 8-bit binary or Gray code.
* **Intermediate Registers:** Hold the bits required for XOR-based conversion.
* **XOR Logic:** Performs the bitwise operations required for conversion.
* **Control Unit:** Uses an FSM to sequence the conversion.
* **Output Registers:** Store the converted 8-bit result.
* **Output Bus:** Provides the result through the shared bus.
* **Completion Signal:** Indicates that the conversion operation has completed.

### FSM Operation

The controller uses the following states:

| State      | Description                                |
| ---------- | ------------------------------------------ |
| `IDLE`     | Waits for a conversion request             |
| `MSB`      | Transfers the most significant bit         |
| `XOR_LOAD` | Loads the bits required for XOR processing |
| `STORE`    | Stores the calculated output bit           |
| `DONE`     | Indicates completion of the conversion     |

The controller uses a bit pointer to process the data sequentially.

## 🔌 Input and Output Signals

| Signal    | Direction | Width  | Description                     |
| --------- | --------- | ------ | ------------------------------- |
| `clk`     | Input     | 1 bit  | Clock signal                    |
| `rst`     | Input     | 1 bit  | Asynchronous reset              |
| `start`   | Input     | 1 bit  | Starts a conversion operation   |
| `convert` | Input     | 1 bit  | Selects conversion direction    |
| `ext_in`  | Input     | 8 bits | Input binary or Gray code       |
| `bus`     | Output    | 8 bits | Shared output bus               |
| `done`    | Output    | 1 bit  | Indicates conversion completion |

### Conversion Selection

| `convert` | Operation      |
| --------- | -------------- |
| `0`       | Binary to Gray |
| `1`       | Gray to Binary |

## 📁 Project Structure

A suggested repository structure is:

```text
Code-Converter-binary-to-grey/
│
├── rtl/
│   └── converter_top.v
│
├── testbench/
│   └── tb_converter_top.sv
│
├── constraints/
│   └── converter_top.sdc
│
├── simulation/
│   └── README.md
│
├── .gitignore
└── README.md
```

**Note:** Adjust the filenames and folders to match your actual project files. Include additional RTL modules, test programs, or scripts if your design uses them.

## 🧪 Verification

The design can be verified using a Verilog/SystemVerilog testbench.

Recommended verification scenarios:

1. Apply reset and check the initial state.
2. Test Binary-to-Gray conversion using different 8-bit inputs.
3. Test Gray-to-Binary conversion using different Gray code inputs.
4. Verify the `start` and `done` control signals.
5. Check the output against reference conversion functions.
6. Test boundary values such as `8'h00` and `8'hFF`.
7. Generate waveform files and inspect the conversion sequence using GTKWave.

A self-checking testbench should compare the DUT output with a reference model and report PASS or FAIL for each test.

## ⏱️ Timing Constraints

The project includes a Synopsys Design Constraints (SDC) file for defining clock and I/O timing requirements.

| Parameter              | Value   |
| ---------------------- | ------- |
| Target clock frequency | 1 GHz   |
| Clock period           | 1 ns    |
| Clock uncertainty      | 0.05 ns |
| Clock transition       | 0.02 ns |
| Maximum input delay    | 0.20 ns |
| Maximum output delay   | 0.20 ns |

These values are example design assumptions for timing analysis, not measured implementation results.

**Important:** Specifying a 1 GHz clock in the SDC file does not prove that the circuit can operate at 1 GHz. Static timing analysis must be performed using the appropriate standard-cell library and implementation conditions.

## 🛠️ Tools and Technologies

* **HDL:** Verilog / SystemVerilog
* **Simulation:** Icarus Verilog
* **Waveform Analysis:** GTKWave
* **Synthesis:** Yosys
* **Static Timing Analysis:** OpenSTA
* **Physical Design:** OpenROAD
* **Constraints:** Synopsys Design Constraints (SDC)

Use the tools relevant to your actual workflow; not every tool is required to simulate the design.

## ▶️ Running the Simulation

If you have Icarus Verilog installed, navigate to the project directory and run:

```bash
iverilog -g2012 -o converter_sim rtl/converter_top.v testbench/tb_converter_top.sv
```

Run the generated simulation:

```bash
vvp converter_sim
```

If the testbench generates a VCD waveform, open it using:

```bash
gtkwave dump.vcd
```

Update the paths and waveform filename to match your actual files.

## 🚀 Future Improvements

* Add more comprehensive self-checking test cases.
* Improve the control logic and verify all FSM transitions.
* Synthesize the design and analyze cell area.
* Perform static timing analysis using a suitable standard-cell library.
* Complete physical implementation and evaluate area, timing, and power.

## 👨‍💻 Author

**Saish Vernekar**

GitHub Repository: [Code-Converter-binary-to-grey](https://github.com/SAISH2510/Code-Converter-binary-to-grey)

--# 8-Bit Binary ↔ Gray Code Converter Using Verilog

## 📌 Project Overview

This project implements an **8-bit Binary-to-Gray and Gray-to-Binary Code Converter** using Verilog HDL. The design uses registers, XOR-based conversion logic, a finite state machine (FSM), and a shared internal bus to perform the conversion operations.

The converter supports both conversion directions and uses control signals to select the required operation. A testbench can be used to verify the conversion functionality, while an SDC file specifies the timing constraints for synthesis and static timing analysis.

## 🎯 Objectives

* Design an 8-bit Binary-to-Gray code converter.
* Implement Gray-to-Binary conversion using XOR logic.
* Develop an FSM-based sequential architecture.
* Verify the design using a Verilog/SystemVerilog testbench.
* Define timing constraints for synthesis and static timing analysis.

## ⚙️ Features

* **8-bit Data Processing:** Supports 8-bit input and output data.
* **Bidirectional Conversion:** Supports Binary-to-Gray and Gray-to-Binary operations.
* **FSM-Based Control:** Uses a finite state machine to sequence conversion operations.
* **Register-Based Architecture:** Uses internal registers to store input and intermediate results.
* **XOR-Based Conversion:** Uses XOR logic for the conversion process.
* **Control Signals:** Uses `start`, `convert`, and `done` to manage the operation.
* **Timing Constraints:** Includes an SDC file targeting a 1 GHz clock frequency.

## 🧠 Conversion Theory

### Binary to Gray Code

The most significant bit (MSB) remains unchanged. Each remaining Gray bit is obtained by XORing two adjacent binary bits.

For an 8-bit binary input:

$$
G_7 = B_7
$$

$$
G_i = B_{i+1} \oplus B_i,\quad 0 \leq i < 7
$$

### Gray Code to Binary

The most significant binary bit remains unchanged. Each subsequent binary bit is obtained by XORing the previous binary bit with the corresponding Gray bit.

$$
B_7 = G_7
$$

$$
B_i = B_{i+1} \oplus G_i,\quad 0 \leq i < 7
$$

Here, \(\oplus\) represents the XOR operation.

## 🏗️ Design Architecture

The design uses the following components:

* **Input Registers:** Store the incoming 8-bit binary or Gray code.
* **Intermediate Registers:** Hold the bits required for XOR-based conversion.
* **XOR Logic:** Performs the bitwise operations required for conversion.
* **Control Unit:** Uses an FSM to sequence the conversion.
* **Output Registers:** Store the converted 8-bit result.
* **Output Bus:** Provides the result through the shared bus.
* **Completion Signal:** Indicates that the conversion operation has completed.

### FSM Operation

The controller uses the following states:

| State      | Description                                |
| ---------- | ------------------------------------------ |
| `IDLE`     | Waits for a conversion request             |
| `MSB`      | Transfers the most significant bit         |
| `XOR_LOAD` | Loads the bits required for XOR processing |
| `STORE`    | Stores the calculated output bit           |
| `DONE`     | Indicates completion of the conversion     |

The controller uses a bit pointer to process the data sequentially.

## 🔌 Input and Output Signals

| Signal    | Direction | Width  | Description                     |
| --------- | --------- | ------ | ------------------------------- |
| `clk`     | Input     | 1 bit  | Clock signal                    |
| `rst`     | Input     | 1 bit  | Asynchronous reset              |
| `start`   | Input     | 1 bit  | Starts a conversion operation   |
| `convert` | Input     | 1 bit  | Selects conversion direction    |
| `ext_in`  | Input     | 8 bits | Input binary or Gray code       |
| `bus`     | Output    | 8 bits | Shared output bus               |
| `done`    | Output    | 1 bit  | Indicates conversion completion |

### Conversion Selection

| `convert` | Operation      |
| --------- | -------------- |
| `0`       | Binary to Gray |
| `1`       | Gray to Binary |

## 📁 Project Structure

A suggested repository structure is:

```text
Code-Converter-binary-to-grey/
│
├── rtl/
│   └── converter_top.v
│
├── testbench/
│   └── tb_converter_top.sv
│
├── constraints/
│   └── converter_top.sdc
│
├── simulation/
│   └── README.md
│
├── .gitignore
└── README.md
```

**Note:** Adjust the filenames and folders to match your actual project files. Include additional RTL modules, test programs, or scripts if your design uses them.

## 🧪 Verification

The design can be verified using a Verilog/SystemVerilog testbench.

Recommended verification scenarios:

1. Apply reset and check the initial state.
2. Test Binary-to-Gray conversion using different 8-bit inputs.
3. Test Gray-to-Binary conversion using different Gray code inputs.
4. Verify the `start` and `done` control signals.
5. Check the output against reference conversion functions.
6. Test boundary values such as `8'h00` and `8'hFF`.
7. Generate waveform files and inspect the conversion sequence using GTKWave.

A self-checking testbench should compare the DUT output with a reference model and report PASS or FAIL for each test.

## ⏱️ Timing Constraints

The project includes a Synopsys Design Constraints (SDC) file for defining clock and I/O timing requirements.

| Parameter              | Value   |
| ---------------------- | ------- |
| Target clock frequency | 1 GHz   |
| Clock period           | 1 ns    |
| Clock uncertainty      | 0.05 ns |
| Clock transition       | 0.02 ns |
| Maximum input delay    | 0.20 ns |
| Maximum output delay   | 0.20 ns |

These values are example design assumptions for timing analysis, not measured implementation results.

**Important:** Specifying a 1 GHz clock in the SDC file does not prove that the circuit can operate at 1 GHz. Static timing analysis must be performed using the appropriate standard-cell library and implementation conditions.

## 🛠️ Tools and Technologies

* **HDL:** Verilog / SystemVerilog
* **Simulation:** Icarus Verilog
* **Waveform Analysis:** GTKWave
* **Synthesis:** Yosys
* **Static Timing Analysis:** OpenSTA
* **Physical Design:** OpenROAD
* **Constraints:** Synopsys Design Constraints (SDC)

Use the tools relevant to your actual workflow; not every tool is required to simulate the design.

## ▶️ Running the Simulation

If you have Icarus Verilog installed, navigate to the project directory and run:

```bash
iverilog -g2012 -o converter_sim rtl/converter_top.v testbench/tb_converter_top.sv
```

Run the generated simulation:

```bash
vvp converter_sim
```

If the testbench generates a VCD waveform, open it using:

```bash
gtkwave dump.vcd
```

Update the paths and waveform filename to match your actual files.

## 🚀 Future Improvements

* Add more comprehensive self-checking test cases.
* Improve the control logic and verify all FSM transitions.
* Synthesize the design and analyze cell area.
* Perform static timing analysis using a suitable standard-cell library.
* Complete physical implementation and evaluate area, timing, and power.





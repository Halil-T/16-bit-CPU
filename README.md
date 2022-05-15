# **Final Project Report**

Halil Turan, Darren Chau, ECE-251

For this project, we decided to implement a 16-bit single cycle CPU.

For the Instruction Set Architecture, we implemented 16 operations, as can be seen in the [operations file](https://github.com/Halil-T/16-bit-SingleCycle-CPU/blob/2bded82533e591941ee77c3c91d5781174cde95a/operations)

To run the cpu, first input "$ iverilog -o cpu alu.v buffer.v RAM.v imem.v CPU.v"
Then run "$ vvp cpu"

To make run your own code in the cpu, create a text file with 32 lines where the instruction is stored in hex. Then in [imem.v](https://github.com/Halil-T/16-bit-SingleCycle-CPU/blob/main/imem.v) change the name of the .txt file to the one you would like to run. Then proceed with the instructions above.

**Instruction Types**

|r-type|i-type|d-type|j-type|
|--|--|--|--|
|ADD |ADDI |STUR |Branch with link  |
|SUB |SUBI |LDUR |Branch to register  |
|AND | | |BEQ |
|OR | | | |
|XOR||||
|NAND||||
|LSL|

**Instruction Formats:**

|Instruction Type |opcode |Rd | Rn| Rm |
|- |- |- |- |- |
|R |opcode |Output register | Input register1| Input register 2 |
|I |opcode |Output register | Input register| Alu Imm |
|D |opcode |Memory Address | Rd| xxxx |
|J |opcode |Register with Addr | 


The CPU implementation can be seen in [cpu.v](https://github.com/Halil-T/16-bit-SingleCycle-CPU/blob/7779641274b5e8eaa3eaa08e5288f92c1515c414/CPU.v). The system clock is implemented in the cpu file. The CPU passes control signals to the appropriate modules of the computer, in this case mostly to the ALU. For branching instructions, the pc is changed to the line of code it is going to, accounting for the pc increment.

The ALU accepts and outputs 16 bit data, and processes the operations to add and subtract, as well as logicaAl and, or, nor, xor, nand, and lsl, as can be seen in [alu.v](https://github.com/Halil-T/16-bit-SingleCycle-CPU/blob/8a1f315729565a28dbdfaa9c44180b4b2302795d/alu.v).

An Instruction Memory module was created, as can be seen in [imem.v](https://github.com/Halil-T/16-bit-SingleCycle-CPU/blob/c05ec792e35b1f362a1120c0e4cf006f49e7682c/imem.v). The imem module loads a file with instructions for the computer into the memory of the computer, to the RAM module. The RAM module in [RAM.v](https://github.com/Halil-T/16-bit-SingleCycle-CPU/blob/8a1f315729565a28dbdfaa9c44180b4b2302795d/RAM.v) stores the data the computer is using.

The Buffer module in [buffer.v](https://github.com/Halil-T/16-bit-SingleCycle-CPU/blob/c05ec792e35b1f362a1120c0e4cf006f49e7682c/buffer.v) was used to help preserve data while it is being transferred between modules on the bus.

# Design Decisions

|Metric     |Attributes    |
|-----|-----|
|16|bit CPU|
|16 |bit ALU Operands |
|16 |Registers |
|16|bit address bus|
|16 |bits for instruction|


# **Timing Diagrams**

**i-type Instruction Timing Diagram**
![image](https://user-images.githubusercontent.com/100239942/168493167-f6529954-f247-475d-af4e-4df05b19b77f.png)

To test this instruction type, R0 was added by R14 (zero register) and 3. It is then subtracted 2 again, and displayed.
code can be found in [I-type-test.txt](https://github.com/Halil-T/16-bit-SingleCycle-CPU/blob/main/I-type_test.txt)

**r-type Instruction Timing Diagram**
![image](https://user-images.githubusercontent.com/100239942/168493226-1e54a3da-58bb-4034-bdf8-f89d9874d194.png)

To test this instruction type, two registers with values already stored have R1 is then shifted by 4 bits, and then it was subtraced by R0, then R1 was displayed.
code can be found in [R-type-test.txt](https://github.com/Halil-T/16-bit-SingleCycle-CPU/blob/main/R-type-test.txt)

**d-type Instruction Timing Diagram**
![image](https://user-images.githubusercontent.com/100239942/168493525-e64541a2-402b-4135-a2cc-95967e64dd0e.png)

To test this instruction type, a value was put into R0 and stored in memory address 0. It was then loaded into R1 and displayed.
code can be found in [D-type-test.txt](https://github.com/Halil-T/16-bit-SingleCycle-CPU/blob/main/D-type-test.txt)

**j-type Instruction Timing Diagram**
![image](https://user-images.githubusercontent.com/100239942/168493607-2f9d9df7-6d22-452b-a7a0-4702c9c9385e.png)

To test this instruction type, R0 is set to 0xF, and the branch address is set to 0xD. between the branch instruction and the display instruction R0 is being increased by one. When it is displayed it still output 0xF.
code can be found in [J-type-test.txt](https://github.com/Halil-T/16-bit-SingleCycle-CPU/blob/main/J-type-test.txt)


# **Architecture Diagrams**

**i-type Instruction Architecture Diagram**
![image](https://user-images.githubusercontent.com/100239942/168492172-57f52f5e-0d07-4fe0-97e5-0ba14d0d689b.png)

Path:

-Instruction is fetched from the instruction memory and the PC is incremented.

-A register value is read from the register file.

-The ALU computes the sum of the value from the register and the sign-extended bits (offset) of the instruction.

-The sum calculated by the ALU is passed to the data memory and used as the address for the data memory.

-The data from the memory unit is written into the register file.


**r-type Instruction Architecture Diagram**
![image](https://user-images.githubusercontent.com/100239942/168492374-c112af33-1bcb-44d2-9b0c-5db57d810203.png)

Path:

-Instruction is fetched from the instruction memory and the PC is incremented.

-Two registers are read from the register file and the main control unit computes the setting of the control lines.

-The ALU operates on the data read from the two registers.

-The ALU result is written into the destination register in the register file.

**j-type Instruction Architecture Diagram**
![image](https://user-images.githubusercontent.com/100239942/168492382-b5154c3e-45a1-478c-b354-34fd835b5055.png)

Path:

-Instruction is fetched from instruction memory and the pc is incremented.

-A register value is read from the register file.

-The ALU passes the data value from the register. The value of the pc is added to the sign-extended bits of the instruction (offset) and the offset is shifted left by two, resulting in branch address.

-The Zero output status information from the ALU is used to decide which adder result to store in the PC.

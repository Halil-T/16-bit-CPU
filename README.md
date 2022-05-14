# **Final Project Report**

Halil Turan, Darren Chau, ECE-251

For this project, we decided to implement a 16-bit single cycle CPU.

For the Instruction Set Architecture, we implemented 16 operations, as can be seen in the [operations file](https://github.com/Halil-T/16-bit-SingleCycle-CPU/blob/2bded82533e591941ee77c3c91d5781174cde95a/operations)

**Instruction Types**

|r-type|i-type|d-type|j-type|
|--|--|--|--|
|ADD |ADDI |STUR |Branch with link  |
|SUB |SUBI |LDUR |Branch to register  |
|AND | | | |
|OR | | | |
|XOR||||
|NAND||||

**Instruction Formats:**

-R type: opcode(4) Rd Rn Rm

-I type: opcode(4) Rd Rn Imm

-D type: opcode(4) addr Rd xxxx

-J type: opcode(4) reg addr

The ALU accepts and outputs 16 bit data, and processe commands to add and subtract, as well as logical and, or, nor, xor, nand, and lsl, as can be seen in [alu.v](https://github.com/Halil-T/16-bit-SingleCycle-CPU/blob/8a1f315729565a28dbdfaa9c44180b4b2302795d/alu.v).

# Design Decisions

|Metric     |Attributes    |
|-----|-----|
|16 |bit ALU Operands |
| | |


**i-type Instruction Architecture Diagram**
![image](https://user-images.githubusercontent.com/100239942/168405058-5b7b6990-ce6e-47ab-bfb2-50241f3ff7df.png)

Path:

-Instruction is fetched from the instruction memory and the PC is incremented.

-A register value is read from the register file.

-The ALU computes the sum of the value from the register and the sign-extended bits (offset) of the instruction.

-The sum calculated by the ALU is passed to the data memory and used as the address for the data memory.

-The data from the memory unit is written into the register file.


**r-type Instruction Architecture Diagram**
![image](https://user-images.githubusercontent.com/100239942/168411315-a5a12db8-cdbc-4126-9306-f0ae6e38b80b.png)

Path:

-Instruction is fetched from the instruction memory and the PC is incremented.

-Two registers are read from the register file and the main control unit computes the setting of the control lines.

-The ALU operates on the data read from the two registers.

-The ALU result is written into the destination register in the register file.

**j-type Instruction Architecture Diagram**
![image](https://user-images.githubusercontent.com/100239942/168411828-e0c01868-7aff-437c-ac12-8857d19c8b97.png)

Path:

-Instruction is fetched from instruction memory and the pc is incremented.

-A register value is read from the register file.

-The ALU passes the data value from the register.

-

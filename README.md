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

-J type: opcode(4) pcinc 

The ALU accepts and outputs 16 bit data, and processe commands to add and subtract, as well as logical and, or, nor, xor, nand, and lsl, as can be seen in [alu.v](https://github.com/Halil-T/16-bit-SingleCycle-CPU/blob/8a1f315729565a28dbdfaa9c44180b4b2302795d/alu.v).

# Design Decisions

|Metric     |Attributes    |
|-----|-----|
|16 |bit ALU Operands |
| | |









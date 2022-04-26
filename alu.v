module alu(
           input [15:0] A,B,  // ALU 16-bit Inputs                 
           input [2:0] ALU_Sel,// ALU Selection
           input [3:0] shamt,
           output [15:0] ALU_Out, // ALU 16-bit Output
           output CarryOut // Carry Out Flag
    );
    reg [15:0] ALU_Result;
    wire [16:0] tmp;
    assign ALU_Out = ALU_Result; // ALU out
    assign tmp = {1'b0,A} + {1'b0,B};
    assign CarryOut = tmp[16]; // Carryout flag

    always @(*)
    begin
        case(ALU_Sel)
          3'b000: // Addition
           ALU_Result = A + B ; 
          3'b001: // Subtraction
           ALU_Result = A - B ;
          3'b010: //  Logical and 
           ALU_Result = A & B;
          3'b011: //  Logical or
           ALU_Result = A | B;
          3'b100: //  Logical xor 
           ALU_Result = A ^ B;
          3'b101: //  Logical nor
           ALU_Result = ~(A | B);
          3'b110: // Logical nand 
           ALU_Result = ~(A & B);
          3'b111: // LSL
           ALU_Result = A<<shamt;
          default: ALU_Result = A + B; 
        endcase
    end
endmodule
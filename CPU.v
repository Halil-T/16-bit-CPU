`timescale 1ns/1ps
module CPU();

    //instruction 15-12 11-8 7-4 3-0

    reg [15:0] instruction;
    reg [15:0] A, B, zero;
    reg [15:0] Rx [15:0];
    reg [2:0] alu_sel;
    reg [3:0] addr, shamt, a, pc;
    reg en_alu, en_imem, we, oe, clk;
    wire [15:0] bus, ins_bus;
    wire carryFlag;
    wire [3:0] Rn, Rd, Rm, opcode;
   
    integer i;

    assign opcode = instruction[15:12];
    assign Rd = instruction[11:8];
    assign Rn = instruction[7:4];
    assign Rm = instruction[3:0];

    wire [15:0] tmp_alu;
    alu aluop(.A(A), .B(B), .ALU_Out(tmp_alu), .ALU_Sel(alu_sel), .CarryOut(carryFlag), .shamt(shamt));
    buffer aluBuff(.clk(clk), .en(en_alu), .in(tmp_alu), .out(bus));
    RAM data(.data(bus), .clk(clk), .we(we), .oe(oe), .addr(addr));
    IMem mem(.a(pc), .data(ins_bus));
    
    always@(posedge clk)
    begin
        case(opcode)
            4'h0:begin      // ADD
                A <= Rx[Rn];
                B <= Rx[Rm];
                alu_sel = 3'b000;
                en_alu = 1'b1;
                #1
                Rx[Rd] = bus;
                en_alu = 1'b0;
            end
            4'h1:begin      // ADDI
                A <= Rx[Rn];
                B <= Rm;
                alu_sel = 3'b000;
                en_alu = 1'b1;
                #1
                Rx[Rd] = bus;
                en_alu = 1'b0;
            end
            4'h2:begin      // SUB
                A <= Rx[Rn];
                B <= Rx[Rm];
                alu_sel = 3'b001;
                en_alu = 1'b1;
                #1
                Rx[Rd] = bus;
                en_alu = 1'b0;
            end
            4'h3:begin      //SUBI
                A <= Rx[Rn];
                B <= Rm;
                alu_sel = 3'b001;
                en_alu = 1'b1;
                #1
                Rx[Rd] = bus;
                en_alu = 1'b0;
            end
            4'h4:begin      //AND
                A <= Rx[Rn];
                B <= Rx[Rm];
                alu_sel = 3'b010;
                en_alu = 1'b1;
                #1
                Rx[Rd] = bus;
                en_alu = 1'b0;
            end
            4'h5:begin      //OR
                A <= Rx[Rn];
                B <= Rx[Rm];
                alu_sel = 3'b011;
                en_alu = 1'b1;
                #1
                Rx[Rd] = bus;
                en_alu = 1'b0;
            end
            4'h6:begin      //XOR
                A <= Rx[Rn];
                B <= Rx[Rm];
                alu_sel = 3'b100;
                en_alu = 1'b1;
                #1
                Rx[Rd] = bus;
                en_alu = 1'b0;
            end
            4'h7:begin      //Display
                $display("%d", Rx[Rd]);
            end
            4'h8:begin      //NAND
                A <= Rx[Rn];
                B <= Rx[Rm];
                alu_sel = 3'b110;
                en_alu = 1'b1;
                #1
                Rx[Rd] = bus;
                en_alu = 1'b0;
            end
            4'h9: $finish;
            4'ha:begin      //LSL
                A <= Rx[Rn];
                shamt <= Rm;
                alu_sel = 3'b111;
                en_alu = 1'b1;
                #1
                Rx[Rd] = bus;
                en_alu = 1'b0;
            end
            4'hb:begin      //BL
                Rx[15] = pc + 1;
                pc = Rx[Rd]-1;
            end
            4'hc:begin      //BEQ (to immediate)
                if(Rx[Rn] == Rx[Rm]) begin
                    pc = Rx[Rd]-1;
                end
            end
            4'hd:begin      //branch to register
                pc = Rx[Rd]-1;
            end
            4'he:begin      //STUR because of the way the registers were implemented, I have to get them onto the bus using the alu
                addr = Rd;
                A <= 0;
                B <= Rx[Rn];
                alu_sel = 'b000;
                en_alu = 1;
                oe = 0;
                we = 1;
                #1
                we = 0;
                en_alu = 0;
            end
            4'hf:begin      //LDUR
                addr = Rd;
                we = 0;
                oe = 1;
                Rx[Rn] = bus;
                oe = 0;
            end
            default : A = 4'hz; //dummy code so it compiles
        endcase
    end

    always @(negedge clk)
    begin
        pc = pc + 1;
        #10
        instruction = ins_bus;
    end

    always #50 clk = ~clk;

    //instruction opcode, rd, rn, rm

    initial begin
        clk = 0;
        {we, oe, en_alu, addr, a, en_imem, zero} <= 0;
        for(i = 0; i < 16; i = i+1) begin
            Rx[i] = 0;
        end
        i = 0;
        pc = -1;
        #100
        $dumpfile("test.vcd");
        $dumpvars(0, clk, instruction, bus, tmp_alu, Rx[0]);
        //$monitor("%d",Rx[1]);
        
    end
endmodule
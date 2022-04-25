module alutb();

    reg [15:0] A, B;
    wire [15:0] bus;
    reg [2:0] sel;
    wire C_out;

    alu FA1(.A(A), .B(B), .ALU_Out(bus), .ALU_Sel(sel), .CarryOut(C_out));

    initial 
    begin
        #10 A <= 0;
        #10 B <= 0;
        #10 sel <= 0;

        #100 //wait for steady state

        #10 A = 16'b1110000000111111;
        #10 B = 16'b0111111110000000;
        #10 sel = 3'b001;

        #100

        $display(bus, C_out);
    end

endmodule
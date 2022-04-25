module bufftb();

    reg [15:0] A, B;
    wire [15:0] bus;
    reg en_b, en_a, clk;

    buffer bA(.clk(clk), .en(en_a), .in(A), .out(bus));
    buffer bB(.clk(clk), .en(en_b), .in(B), .out(bus));

    always #50 clk = ~clk;

    initial begin
        {clk, en_a, en_b} <= 0;
        A <= 16'b1111111111111111;
        B <= 16'b0000000000000000;

        #100 en_a = 1'b1;
        $display(bus);
        #100 en_a = 1'b0;
        $display(bus);
        #100 en_b = 1'b1;
        $display(bus);
        #100 en_b = 1'b0;
        $display(bus);
        $finish
    end

endmodule
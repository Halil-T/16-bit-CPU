module buffer(input [15:0] in, 
              input en, clk,
              output reg [15:0] out);
    
    always @(*) begin
        if(en)
            out <= in;
        else
            out <= 16'bzzzzzzzzzzzzzzzz; // high impedence output to not interfere with bus
    end

endmodule
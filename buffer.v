module buffer(input [15:0] in, 
              input en, clk,
              output reg [15:0] out);
    
    always @(*) begin
        if(en)
            out <= in;
        else
            out <= 16'bzzzzzzzzzzzzzzzz;
    end

endmodule
module RAM(
        inout [15:0] data,
        input [3:0] addr,
        input we, clk, oe
        );

    reg [15:0] ram [15:0];
    reg [15:0] tmp_data;

    always @ (posedge clk)
    begin
        if(we)
            ram[addr] <= data;  
        else
            tmp_data <= data;
    end

    assign data = oe & !we ? tmp_data : 'hz;

endmodule
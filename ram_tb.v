module ramtb();

    reg [3:0] addr;
    wire [15:0] out;
    integer i;

    IMem mem(.data(out), .a(addr));

    initial begin
        addr = 0;

        for(i = 0; i < 16; i = i + 1) begin
            addr = i;
            #10
            $display(out);
        end
    end

endmodule
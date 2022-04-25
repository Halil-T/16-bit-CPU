module IMem(
        output wire [15:0] data,
        input [3:0] a);

    reg [15:0] ram [0:31];

    initial $readmemh("memfile.txt", ram);

    assign data = ram[a];

endmodule
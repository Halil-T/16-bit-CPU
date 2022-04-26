module IMem(
        output wire [15:0] data,
        input [3:0] a);

    reg [15:0] ram [0:31];

    initial $readmemh("fibb_recur.txt", ram); // load file with instructions onto memory

    assign data = ram[a];

endmodule
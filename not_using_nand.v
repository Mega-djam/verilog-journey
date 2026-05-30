module not_using_nand(
    input a,
    output y
);

nand_gate g1(.a(a), .b(a), .y(y));

endmodule
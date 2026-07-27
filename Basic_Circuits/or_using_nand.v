module or_using_nand_gate(
    input a,b,
    output c
);

wire  w1, w2;

nand_gate u(.a(a), .b(a), .y(w1));
nand_gate u1(.a(b), .b(b), .y(w2));
nand_gate u2(.a(w1), .b(w2), .y(c));

endmodule


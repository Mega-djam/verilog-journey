module xor_using_nand_gate(
    input a,b,
    output y
);

wire w1, w2, w3;

nand_gate g1(.a(a), .b(b), .y(w1));
nand_gate g2(.a(a), .b(w1), .y(w2));
nand_gate g3(.a(b), .b(w1), .y(w3));
nand_gate g4(.a(w2), .b(w3), .y(y));

endmodule
module and_using_nand_gate(
    input a,
    input b,
    output c
);
wire w;
nand_gate u(.a(a), .b(b), .y(w));
assign c=~w;

endmodule

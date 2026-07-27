module mux_2_to_1(
	input a, b, sel,
	output y
);

wire w1,w2, w3; 
//Gate level model using nand gate 

not_using_nand g1(.a(sel), .y(w1));
and_using_nand_gate g2(.a(a), .b(w1), .c(w2));
and_using_nand_gate g3(.a(b), .b(sel), .c(w3));
or_using_nand_gate g4(.a(w2), .b(w3), .c(y));

endmodule


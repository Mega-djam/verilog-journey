module mux_4_to_1(
	input  a, b, c, d, sel0, sel1,
	output y
);

//4:1 Mux design using Dataflow Model

assign y = sel1?(sel0?d:b):(sel0?c:a);

endmodule

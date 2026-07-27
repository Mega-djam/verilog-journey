module bit_mux_2(
    input [1:0]a, 
    input [1:0]b, 
    input sel,
    output [1:0]y
);

//Using 2:1 mux

mux_2_to_1 mux1(.a(a[0]), .b(b[0]), .sel(sel), .y(y[0]));
mux_2_to_1 mux2(.a(a[1]), .b(b[1]), .sel(sel), .y(y[1]));

endmodule
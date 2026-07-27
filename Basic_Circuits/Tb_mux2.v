module tb_mux_2_to_1;

reg a, b, sel;
wire w;

mux_2_to_1 dut(.a(a), .b(b), .sel(sel), .y(w));

initial begin

a=0;b=0;sel=0;
#10 a=1;b=0;sel=0;
#10 a=0;b=0;sel=1;
#10 a=0;b=1;sel=1;
#10 $finish;
end
endmodule

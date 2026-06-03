module tb_mux_4_to_1;

reg [3:0]a;
reg [1:0]sel;
wire out;

mux_4_to_1 dut(.a(a[0]), .b(a[1]), .c(a[2]), .d(a[3]), .sel0(sel[0]), .sel1(sel[1]), .y(out));

initial begin
//when all lines in the input is zero
a=4'b0000; sel=2'b00;
#10 a=4'b0000; sel=2'b01;
#10 a=4'b0000; sel=2'b10;
#10 a=4'b0000; sel=2'b11;

//when one line in the input is one
#10 a=4'b0001; sel=2'b00;
#10 a=4'b0001; sel=2'b01;
#10 a=4'b0001; sel=2'b10;
#10 a=4'b0001; sel=2'b11;

//when one line in the input is one
#10 a=4'b0010; sel=2'b00;
#10 a=4'b0010; sel=2'b01;
#10 a=4'b0010; sel=2'b10;
#10 a=4'b0010; sel=2'b11;

//when one line in the input is one
#10 a=4'b0100; sel=2'b00;
#10 a=4'b0100; sel=2'b01;
#10 a=4'b0100; sel=2'b10;
#10 a=4'b0100; sel=2'b11;

//when one line in the input is one
#10 a=4'b1000; sel=2'b00;
#10 a=4'b1000; sel=2'b01;
#10 a=4'b1000; sel=2'b10;
#10 a=4'b1000; sel=2'b11;
#10 $finish;
end
endmodule
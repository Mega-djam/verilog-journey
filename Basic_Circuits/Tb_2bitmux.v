module tb_bit_mux_2;

reg [1:0]a;
reg [1:0]b;
reg sel;
wire [1:0]y;

bit_mux_2 dut(.a(a), .b(b), .sel(sel), .y(y));

initial begin

a=2'b00;b=2'b00;sel=0;
#10 a=2'b01;b=2'b00;sel=0;
#10 a=2'b10;b=2'b00;sel=0;
#10 a=2'b11;b=2'b00;sel=0;

#10 a=2'b00;b=2'b01;sel=0;
#10 a=2'b00;b=2'b10;sel=0;
#10 a=2'b00;b=2'b11;sel=0;

#10 a=2'b00;b=2'b00;sel=1;
#10 a=2'b00;b=2'b01;sel=1;
#10 a=2'b00;b=2'b10;sel=1;
#10 a=2'b00;b=2'b11;sel=1;

#10 a=2'b01;b=2'b00;sel=1;
#10 a=2'b10;b=2'b00;sel=1;
#10 a=2'b11;b=2'b00;sel=1;
#10 $finish;
end
endmodule



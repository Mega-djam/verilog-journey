module tb_not_gate;

reg a;
wire op;

not_gate dut_not(.a(a), .b(op));

initial begin
a=0;
#10 a=1;
#10 $finish;
end
endmodule
module tb_or_gate;

reg a, b;
wire op;
or_gate dut(.a(a), .b(b), .y(op));

initial begin
$display("Desing Under Testing testbench for Or gate");
a=0;b=0;
#10 a=0;b=1;
#10 a=1;b=0;
#10 a=1;b=1;
#10 $finish;
end

endmodule

module tb_not_using_nand_gate;

reg a;
wire op;

not_using_nand dut(.a(a), .y(op));

initial begin
a=0;
#10 a=1;
#10 $finish;
end
endmodule


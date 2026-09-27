`timescale 1ns/1ps
module riscv_cpu_tb;

    reg clk;
    reg reset;
    riscv_cpu DUT(.clk(clk),.reset(reset));

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial 
    begin
        reset = 1'b1;
        #20;
        reset = 1'b0;
      #500;
        $stop;
    end

    initial 
    begin
        $monitor("Time=%0t | Reset=%b | PC=%h | Instruction=%h", $time, reset, DUT.pc, DUT.instruction);
    end

    always @(posedge clk) begin
        if (!reset) 
        begin
            $display(
                "Time=%0t | PC=%h | x1=%h | x2=%h | x3=%h | x4=%h | x5=%h | x6=%h", $time,
                DUT.pc,
                DUT.REGFILE.registers[1],
                DUT.REGFILE.registers[2],
                DUT.REGFILE.registers[3],
                DUT.REGFILE.registers[4],
                DUT.REGFILE.registers[5],
                DUT.REGFILE.registers[6]
            );
        end
    end
endmodule
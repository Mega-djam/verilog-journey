module testbench;

    reg a, b;
    wire sum, car;

    half_adder dut(.a(a), .b(b), .s(sum), .c(car));
    initial
        begin
            $monitor($time, "a=%b, b=%b, s=%b, c=%b", a, b, sum, car);
            a=0; b=0;
            #5 a=1;b=0;
            #5 a=0;b=1;
            #5 a=1;b=1;
        #5 $finish;
    end
endmodule


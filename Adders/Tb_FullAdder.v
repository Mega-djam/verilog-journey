module tb_full_adder;

    reg a, b, c;
    wire sum, car;
    full_Adder dut(a, b, c, sum, car);

    initial 
        begin
            $monitor($time," a=%b, b=%b, c=%b, sum=%b, car=%b ", a, b, c, sum, car);
            a=0;b=0;c=0;
            #5 a=0;b=0;c=1;
            #5 a=0;b=1;c=0;
            #5 a=0;b=1;c=1;
            #5 a=1;b=0;c=0;
            #5 a=1;b=0;c=1;
            #5 a=1;b=1;c=0;
            #5 a=1;b=1;c=1;
            #5 
        $finish;
    end
endmodule
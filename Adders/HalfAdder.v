module half_adder(a, b, s, c);

    input a, b;
    output s, c;
    xor_gate s1(a, b, s);   //sum
    and_gate c1(a, b, c);   //carry

endmodule;

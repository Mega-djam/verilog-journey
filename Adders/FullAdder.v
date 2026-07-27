module full_Adder(a, b, c, sum, carry);
    
    input a, b, c;
    output sum, carry;
    wire w1, w2, w3, w4, w5;
    
    //sum
    xor_gate s1(a, b, w1);
    xor_gate s2(w1, c, sum);

    //carry
    and_gate c1(a, b, w2);
    and_gate c2(b, c, w3);
    and_gate c3(a, c, w4);
    or_gate c4(w2, w3, w5);
    or_gate c5(w4, w5, carry);

endmodule;

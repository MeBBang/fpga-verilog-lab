module logic_gate(
    input  a,
    input  b,
    output y_and,
    output y_or,
    output y_xor,
    output y_nor,
    output y_nand
    );

    assign y_and  =   a & b;
    assign y_or   =   a | b;
    assign y_xor  =   a ^ b;
    assign y_nor  = ~(a | b);
    assign y_nand = ~(a & b);

endmodule

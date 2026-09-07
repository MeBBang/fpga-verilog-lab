module full_adder(
    input  a,
    input  b,
    input  cin,
    output cout,
    output sum
    );

    wire s1, c1, c2;

    HA u1 (.a(a),  .b(b),   .c(c1), .s(s1));
    HA u2 (.a(s1), .b(cin), .c(c2), .s(sum));

    assign cout = c1 | c2;

endmodule

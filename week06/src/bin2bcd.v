module bin2bcd(
    input  [3:0] bin,
    output [7:0] bcd
    );

    assign bcd = (bin > 4'd9) ? {4'd1, bin - 4'd10} : {4'd0, bin};

endmodule

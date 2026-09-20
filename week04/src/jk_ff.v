module jk_ff(
    input      j,
    input      k,
    input      clk,
    output reg q
    );

    initial q = 1'b0;

    always @(posedge clk) begin
        case ({j, k})
            2'b00 : q <= q;
            2'b01 : q <= 1'b0;
            2'b10 : q <= 1'b1;
            2'b11 : q <= ~q;
        endcase
    end

endmodule

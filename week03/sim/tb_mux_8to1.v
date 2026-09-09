module tb_mux_8to1;

    reg  [3:0] d0, d1, d2, d3, d4, d5, d6, d7;
    reg  [2:0] sel;
    wire [3:0] y;
    integer    i;

    mux_8to1 uut (d0, d1, d2, d3, d4, d5, d6, d7, sel, y);

    initial begin
        d0 = 4'b0011;
        d1 = 4'b0101;
        d2 = 4'b1001;
        d3 = 4'b1100;
        d4 = 4'b0110;
        d5 = 4'b1010;
        d6 = 4'b1111;
        d7 = 4'b0001;
        for (i = 0; i < 8; i = i + 1) begin
            sel = i[2:0];
            #100;
        end
        $finish;
    end

endmodule

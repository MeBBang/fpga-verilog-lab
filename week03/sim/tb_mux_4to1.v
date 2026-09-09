module tb_mux_4to1;

    reg  [1:0] d0, d1, d2, d3, sel;
    wire [1:0] y;
    integer    i;

    mux_4to1 uut (d0, d1, d2, d3, sel, y);

    initial begin
        d0 = 2'b01;
        d1 = 2'b10;
        d2 = 2'b11;
        d3 = 2'b00;
        for (i = 0; i < 4; i = i + 1) begin
            sel = i[1:0];
            #100;
        end
        $finish;
    end

endmodule

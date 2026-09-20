module tb_t_ff_oneshot;

    reg  t, clk, rst;
    wire q;

    t_ff_oneshot uut (t, clk, rst, q);

    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        t   = 1'b0;
        #20 rst = 1'b0;
        repeat (3) begin
            #30 t = 1'b1;
            #30 t = 1'b0;
        end
        #30 $finish;
    end

endmodule

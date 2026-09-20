module tb_d_ff;

    reg  d, clk;
    wire q;

    d_ff uut (d, clk, q);

    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;
        d   = 1'b0;
        repeat (3) begin
            #30 d = 1'b1;
            #30 d = 1'b0;
        end
        #30 $finish;
    end

endmodule

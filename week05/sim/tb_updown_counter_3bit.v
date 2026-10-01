module tb_updown_counter_3bit;

    reg        clk, rst, x;
    wire [2:0] state;

    updown_counter_3bit uut (clk, rst, x, state);

    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        x   = 1'b0;
        #20 rst = 1'b1;
        repeat (16) begin
            #20 x = 1'b1;
            #20 x = 1'b0;
        end
        #30 $finish;
    end

endmodule

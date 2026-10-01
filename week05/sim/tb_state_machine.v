module tb_state_machine;

    reg        clk, rst, x;
    wire       y;
    wire [1:0] state;

    state_machine uut (clk, rst, x, y, state);

    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        x   = 1'b0;
        #20 rst = 1'b1;
        x = 1'b1;
        #10 x = 1'b0;
        #10 x = 1'b1;
        #10 x = 1'b1;
        #10 x = 1'b1;
        #10 x = 1'b1;
        #10 x = 1'b0;
        #10 x = 1'b1;
        #10 x = 1'b1;
        #10 x = 1'b0;
        #10 x = 1'b0;
        #10 $finish;
    end

endmodule

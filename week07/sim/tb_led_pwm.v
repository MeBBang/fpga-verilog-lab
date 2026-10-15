module tb_led_pwm;

    reg        clk, rst;
    reg  [7:0] bin;
    wire       led_signal;

    led_pwm uut (clk, rst, bin, led_signal);

    always #500 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        bin = 8'd0;
        #10_000  rst = 1'b0;
        #512_000 bin = 8'd64;
        #512_000 bin = 8'd128;
        #512_000 bin = 8'd192;
        #512_000 bin = 8'd255;
        #522_000 $finish;
    end

endmodule

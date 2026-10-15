module tb_rgb_led;

    reg        clk, rst;
    reg  [7:0] btn;
    wire [3:0] led_signal_R, led_signal_G, led_signal_B;

    rgb_led uut (clk, rst, btn, led_signal_R, led_signal_G, led_signal_B);

    always #500 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        btn = 8'b00000000;
        #10_000  rst = 1'b0;
                 btn = 8'b00000001;
        #10_000  btn = 8'b00000000;
        #501_000 btn = 8'b00000010;
        #10_000  btn = 8'b00000000;
        #502_000 btn = 8'b00000100;
        #10_000  btn = 8'b00000000;
        #507_000 $finish;
    end

endmodule

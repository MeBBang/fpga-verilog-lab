module led_pwm(
    input        clk,
    input        rst,
    input  [7:0] bin,
    output       led_signal
    );

    wire [7:0] cnt;

    counter8       c1 (clk, rst, cnt);
    pwm_comparator p1 (clk, rst, cnt, bin, led_signal);

endmodule

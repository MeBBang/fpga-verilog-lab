module led_control(
    input        clk,
    input        rst,
    input  [7:0] bin,
    output [7:0] seg_data,
    output [7:0] seg_sel,
    output       led_signal
    );

    led_pwm         p1 (clk, rst, bin, led_signal);
    seg7_controller s1 (clk, rst, bin, seg_data, seg_sel);

endmodule

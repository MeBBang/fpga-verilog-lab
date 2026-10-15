module pwm_comparator(
    input            clk,
    input            rst,
    input      [7:0] cnt,
    input      [7:0] level,
    output reg       pwm
    );

    always @(posedge rst or posedge clk) begin
        if (rst)
            pwm <= 1'b0;
        else
            pwm <= (level == 8'd255) || (cnt < level);
    end

endmodule

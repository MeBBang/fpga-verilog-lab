module counter_2bit(
    input            clk,
    input            rst,
    input            x,
    output reg [1:0] state
    );

    reg x_reg, x_trig;

    always @(negedge rst or posedge clk) begin
        if (!rst)
            {x_reg, x_trig} <= 2'b00;
        else begin
            x_reg  <= x;
            x_trig <= x & ~x_reg;
        end
    end

    always @(negedge rst or posedge clk) begin
        if (!rst)
            state <= 2'b00;
        else if (x_trig)
            state <= state + 2'b01;
    end

endmodule

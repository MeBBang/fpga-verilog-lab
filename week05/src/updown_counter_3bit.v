module updown_counter_3bit(
    input            clk,
    input            rst,
    input            x,
    output reg [2:0] state
    );

    reg x_reg, x_trig;
    reg up;

    always @(negedge rst or posedge clk) begin
        if (!rst)
            {x_reg, x_trig} <= 2'b00;
        else begin
            x_reg  <= x;
            x_trig <= x & ~x_reg;
        end
    end

    always @(negedge rst or posedge clk) begin
        if (!rst) begin
            state <= 3'b000;
            up    <= 1'b1;
        end
        else if (x_trig) begin
            if (up) begin
                state <= state + 3'b001;
                if (state == 3'b110) up <= 1'b0;
            end
            else begin
                state <= state - 3'b001;
                if (state == 3'b001) up <= 1'b1;
            end
        end
    end

endmodule

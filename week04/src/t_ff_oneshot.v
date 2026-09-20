module t_ff_oneshot(
    input      t,
    input      clk,
    input      rst,
    output reg q
    );

    reg t_reg;
    reg t_trig;

    always @(posedge clk) begin
        if (rst) begin
            t_reg  <= 1'b0;
            t_trig <= 1'b0;
        end
        else begin
            t_reg  <= t;
            t_trig <= t & ~t_reg;
        end
    end

    always @(posedge clk) begin
        if (rst)
            q <= 1'b0;
        else if (t_trig)
            q <= ~q;
    end

endmodule

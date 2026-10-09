module oneshot(
    input      clk,
    input      rst,
    input      btn,
    output reg btn_trig
    );

    reg btn_reg;

    always @(negedge rst or posedge clk) begin
        if (!rst)
            {btn_reg, btn_trig} <= 2'b00;
        else begin
            btn_reg  <= btn;
            btn_trig <= btn & ~btn_reg;
        end
    end

endmodule

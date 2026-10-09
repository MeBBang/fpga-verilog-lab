module seg_counter(
    input        clk,
    input        rst,
    input        btn,
    output [7:0] seg
    );

    wire      btn_trig;
    reg [3:0] state;

    oneshot     o1 (clk, rst, btn, btn_trig);
    seg_decoder d1 (state, seg);

    always @(negedge rst or posedge clk) begin
        if (!rst)
            state <= 4'd0;
        else if (btn_trig)
            state <= (state == 4'd9) ? 4'd0 : state + 4'd1;
    end

endmodule

module seg_array(
    input            clk,
    input            rst,
    input            btn,
    output     [7:0] seg_data,
    output reg [7:0] seg_sel
    );

    wire       btn_trig;
    reg  [3:0] state_bin;
    wire [7:0] state_bcd;
    reg  [3:0] bcd;

    oneshot     o1 (clk, rst, btn, btn_trig);
    bin2bcd     b1 (state_bin, state_bcd);
    seg_decoder d1 (bcd, seg_data);

    always @(negedge rst or posedge clk) begin
        if (!rst)
            state_bin <= 4'd0;
        else if (btn_trig)
            state_bin <= state_bin + 4'd1;
    end

    always @(negedge rst or posedge clk) begin
        if (!rst)
            seg_sel <= 8'b11111110;
        else
            seg_sel <= {seg_sel[6:0], seg_sel[7]};
    end

    always @(*) begin
        case (seg_sel)
            8'b11111110 : bcd = state_bcd[3:0];
            8'b11111101 : bcd = state_bcd[7:4];
            default     : bcd = 4'b0000;
        endcase
    end

endmodule

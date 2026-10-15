module seg7_controller(
    input            clk,
    input            rst,
    input      [7:0] bin,
    output     [7:0] seg_data,
    output reg [7:0] seg_sel
    );

    wire [11:0] bcd;
    reg  [3:0]  display_bcd;

    bin2bcd     b1 (clk, rst, bin, bcd);
    seg_decoder d1 (display_bcd, seg_data);

    always @(posedge rst or posedge clk) begin
        if (rst)
            seg_sel <= 8'b11111110;
        else
            seg_sel <= {seg_sel[6:0], seg_sel[7]};
    end

    always @(*) begin
        case (seg_sel)
            8'b11111110 : display_bcd = bcd[3:0];
            8'b11111101 : display_bcd = bcd[7:4];
            8'b11111011 : display_bcd = bcd[11:8];
            default     : display_bcd = 4'd0;
        endcase
    end

endmodule

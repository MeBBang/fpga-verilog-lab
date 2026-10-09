module piezo_piano(
    input            clk,
    input            rst,
    input      [7:0] btn,
    output reg       piezo
    );

    parameter C2 = 12'd3830;
    parameter D2 = 12'd3400;
    parameter E2 = 12'd3038;
    parameter F2 = 12'd2864;
    parameter G2 = 12'd2550;
    parameter A2 = 12'd2272;
    parameter B2 = 12'd2028;
    parameter C3 = 12'd1912;

    reg [11:0] cnt;
    reg [11:0] cnt_limit;

    always @(*) begin
        case (btn)
            8'b00000001 : cnt_limit = C2;
            8'b00000010 : cnt_limit = D2;
            8'b00000100 : cnt_limit = E2;
            8'b00001000 : cnt_limit = F2;
            8'b00010000 : cnt_limit = G2;
            8'b00100000 : cnt_limit = A2;
            8'b01000000 : cnt_limit = B2;
            8'b10000000 : cnt_limit = C3;
            default     : cnt_limit = 12'd0;
        endcase
    end

    always @(negedge rst or posedge clk) begin
        if (!rst) begin
            cnt   <= 12'd0;
            piezo <= 1'b0;
        end
        else if (cnt_limit == 12'd0) begin
            cnt   <= 12'd0;
            piezo <= 1'b0;
        end
        else if (cnt >= cnt_limit / 2 - 1) begin
            cnt   <= 12'd0;
            piezo <= ~piezo;
        end
        else
            cnt <= cnt + 12'd1;
    end

endmodule

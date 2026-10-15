module bin2bcd(
    input             clk,
    input             rst,
    input       [7:0] bin,
    output reg [11:0] bcd
    );

    reg  [2:0]  i;
    reg  [11:0] work;
    wire [3:0]  d2, d1, d0;

    assign d2 = (work[11:8] >= 4'd5) ? work[11:8] + 4'd3 : work[11:8];
    assign d1 = (work[7:4]  >= 4'd5) ? work[7:4]  + 4'd3 : work[7:4];
    assign d0 = (work[3:0]  >= 4'd5) ? work[3:0]  + 4'd3 : work[3:0];

    always @(posedge rst or posedge clk) begin
        if (rst) begin
            i    <= 3'd0;
            work <= 12'd0;
            bcd  <= 12'd0;
        end
        else begin
            if (i == 3'd0) begin
                bcd  <= work;
                work <= {11'd0, bin[7]};
            end
            else
                work <= {d2[2:0], d1, d0, bin[3'd7 - i]};
            i <= i + 3'd1;
        end
    end

endmodule

module counter8(
    input            clk,
    input            rst,
    output reg [7:0] cnt
    );

    always @(posedge rst or posedge clk) begin
        if (rst)
            cnt <= 8'd0;
        else
            cnt <= cnt + 8'd1;
    end

endmodule

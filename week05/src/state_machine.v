module state_machine(
    input            clk,
    input            rst,
    input            x,
    output           y,
    output reg [1:0] state
    );

    always @(negedge rst or posedge clk) begin
        if (!rst)
            state <= 2'b00;
        else begin
            case (state)
                2'b00 : state <= x ? 2'b01 : 2'b00;
                2'b01 : state <= x ? 2'b11 : 2'b00;
                2'b10 : state <= x ? 2'b10 : 2'b00;
                2'b11 : state <= x ? 2'b10 : 2'b00;
            endcase
        end
    end

    assign y = (state[1] | state[0]) & ~x;

endmodule

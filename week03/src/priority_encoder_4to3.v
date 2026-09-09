module priority_encoder_4to3(
    input  [3:0] d,
    output reg   x,
    output reg   y,
    output reg   v
    );

    always @(*) begin
        if (d[3]) begin
            {x, y, v} = 3'b111;
        end else if (d[2]) begin
            {x, y, v} = 3'b101;
        end else if (d[1]) begin
            {x, y, v} = 3'b011;
        end else if (d[0]) begin
            {x, y, v} = 3'b001;
        end else begin
            {x, y, v} = 3'b000;
        end
    end

endmodule

module rgb_led(
    input        clk,
    input        rst,
    input  [7:0] btn,
    output [3:0] led_signal_R,
    output [3:0] led_signal_G,
    output [3:0] led_signal_B
    );

    parameter red    = {8'd255, 8'd0,   8'd0  };
    parameter orange = {8'd255, 8'd102, 8'd0  };
    parameter yellow = {8'd255, 8'd255, 8'd0  };
    parameter green  = {8'd0,   8'd255, 8'd0  };
    parameter blue   = {8'd0,   8'd0,   8'd255};
    parameter indigo = {8'd0,   8'd0,   8'd128};
    parameter purple = {8'd128, 8'd0,   8'd128};
    parameter white  = {8'd255, 8'd255, 8'd255};

    wire [7:0]  cnt;
    reg  [23:0] state;
    wire        pwm_R, pwm_G, pwm_B;

    counter8       c1 (clk, rst, cnt);
    pwm_comparator pr (clk, rst, cnt, state[23:16], pwm_R);
    pwm_comparator pg (clk, rst, cnt, state[15:8],  pwm_G);
    pwm_comparator pb (clk, rst, cnt, state[7:0],   pwm_B);

    assign led_signal_R = {4{pwm_R}};
    assign led_signal_G = {4{pwm_G}};
    assign led_signal_B = {4{pwm_B}};

    always @(posedge rst or posedge clk) begin
        if (rst)
            state <= 24'd0;
        else begin
            case (btn)
                8'b00000001 : state <= red;
                8'b00000010 : state <= orange;
                8'b00000100 : state <= yellow;
                8'b00001000 : state <= green;
                8'b00010000 : state <= blue;
                8'b00100000 : state <= indigo;
                8'b01000000 : state <= purple;
                8'b10000000 : state <= white;
                default     : state <= state;
            endcase
        end
    end

endmodule

module lcd_cursor(
    input            rst,
    input            clk,
    output           LCD_E,
    output reg       LCD_RS,
    output reg       LCD_RW,
    output reg [7:0] LCD_DATA,
    output reg [7:0] LED_out,
    input      [9:0] number_btn,
    input      [1:0] control_btn
    );

    parameter DELAY        = 3'b000;
    parameter FUNCTION_SET = 3'b001;
    parameter DISP_ONOFF   = 3'b010;
    parameter ENTRY_MODE   = 3'b011;
    parameter SET_ADDRESS  = 3'b100;
    parameter DELAY_T      = 3'b101;
    parameter WRITE        = 3'b110;
    parameter CURSOR       = 3'b111;

    wire [9:0] number_btn_t;
    wire [1:0] control_btn_t;

    reg [2:0] state;
    reg [7:0] cnt;
    reg       e_en;

    oneshot_universal #(.WIDTH(12)) O1 (clk, rst, {number_btn, control_btn}, {number_btn_t, control_btn_t});

    assign LCD_E = clk & e_en;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state   <= DELAY;
            LED_out <= 8'b0000_0000;
        end
        else begin
            case (state)
                DELAY        : begin if (cnt == 70)  state <= FUNCTION_SET; LED_out <= 8'b1000_0000; end
                FUNCTION_SET : begin if (cnt == 30)  state <= DISP_ONOFF;   LED_out <= 8'b0100_0000; end
                DISP_ONOFF   : begin if (cnt == 30)  state <= ENTRY_MODE;   LED_out <= 8'b0010_0000; end
                ENTRY_MODE   : begin if (cnt == 30)  state <= SET_ADDRESS;  LED_out <= 8'b0001_0000; end
                SET_ADDRESS  : begin if (cnt == 100) state <= DELAY_T;      LED_out <= 8'b0000_1000; end
                DELAY_T      : begin
                                   state   <= |number_btn_t ? WRITE : (|control_btn_t ? CURSOR : DELAY_T);
                                   LED_out <= 8'b0000_0100;
                               end
                WRITE        : begin if (cnt == 30)  state <= DELAY_T;      LED_out <= 8'b0000_0010; end
                CURSOR       : begin if (cnt == 30)  state <= DELAY_T;      LED_out <= 8'b0000_0001; end
            endcase
        end
    end

    always @(posedge clk or negedge rst) begin
        if (!rst)
            cnt <= 8'b0000_0000;
        else begin
            case (state)
                DELAY        : if (cnt >= 70)  cnt <= 0; else cnt <= cnt + 1;
                FUNCTION_SET : if (cnt >= 30)  cnt <= 0; else cnt <= cnt + 1;
                DISP_ONOFF   : if (cnt >= 30)  cnt <= 0; else cnt <= cnt + 1;
                ENTRY_MODE   : if (cnt >= 30)  cnt <= 0; else cnt <= cnt + 1;
                SET_ADDRESS  : if (cnt >= 100) cnt <= 0; else cnt <= cnt + 1;
                DELAY_T      : cnt <= 0;
                WRITE        : if (cnt >= 30)  cnt <= 0; else cnt <= cnt + 1;
                CURSOR       : if (cnt >= 30)  cnt <= 0; else cnt <= cnt + 1;
            endcase
        end
    end

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            e_en <= 1'b0;
            {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0001;
        end
        else begin
            e_en <= (state != DELAY);
            case (state)
                FUNCTION_SET : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0011_1000;
                DISP_ONOFF   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111;
                ENTRY_MODE   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0110;
                SET_ADDRESS  : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0001;
                DELAY_T      : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111;
                WRITE        : if (cnt == 20)
                                   case (number_btn)
                                       10'b1000_0000_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0001;
                                       10'b0100_0000_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0010;
                                       10'b0010_0000_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0011;
                                       10'b0001_0000_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0100;
                                       10'b0000_1000_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0101;
                                       10'b0000_0100_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0110;
                                       10'b0000_0010_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0111;
                                       10'b0000_0001_00 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1000;
                                       10'b0000_0000_10 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_1001;
                                       10'b0000_0000_01 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b1_0_0011_0000;
                                   endcase
                               else
                                   {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111;
                CURSOR       : if (cnt == 20)
                                   case (control_btn)
                                       2'b10 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0001_0000;
                                       2'b01 : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0001_0100;
                                   endcase
                               else
                                   {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111;
            endcase
        end
    end

endmodule

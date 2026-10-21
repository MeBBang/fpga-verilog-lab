module text_lcd_marquee(
    input            clk,
    input            rst,
    output           LCD_E,
    output reg       LCD_RS,
    output reg       LCD_RW,
    output reg [7:0] LCD_DATA,
    output reg [7:0] LED_out
    );

    parameter DELAY        = 3'b000;
    parameter FUNCTION_SET = 3'b001;
    parameter ENTRY_MODE   = 3'b010;
    parameter DISP_ONOFF   = 3'b011;
    parameter LINE1        = 3'b100;
    parameter LINE2        = 3'b101;
    parameter DELAY_T      = 3'b110;
    parameter CLEAR_DISP   = 3'b111;

    parameter TEXT1 = " Hello World!   ";
    parameter TEXT2 = "2025440019 KDH  ";

    reg [2:0] state;
    integer   cnt;
    reg       e_en;

    assign LCD_E = clk & e_en;

    always @(negedge rst or posedge clk) begin
        if (!rst) begin
            state <= DELAY;
            cnt   <= 0;
        end
        else begin
            cnt <= cnt + 1;
            case (state)
                DELAY        : if (cnt == 70) begin state <= FUNCTION_SET; cnt <= 0; end
                FUNCTION_SET : if (cnt == 30) begin state <= DISP_ONOFF;   cnt <= 0; end
                DISP_ONOFF   : if (cnt == 30) begin state <= ENTRY_MODE;   cnt <= 0; end
                ENTRY_MODE   : if (cnt == 30) begin state <= CLEAR_DISP;   cnt <= 0; end
                LINE1        : if (cnt == 16) begin state <= LINE2;        cnt <= 0; end
                LINE2        : if (cnt == 16) begin state <= DELAY_T;      cnt <= 0; end
                DELAY_T      : if (cnt == 299) cnt <= 0;
                CLEAR_DISP   : if (cnt == 5)  begin state <= LINE1;        cnt <= 0; end
            endcase
        end
    end

    always @(*) begin
        case (state)
            DELAY        : LED_out = 8'b1000_0000;
            FUNCTION_SET : LED_out = 8'b0100_0000;
            DISP_ONOFF   : LED_out = 8'b0010_0000;
            ENTRY_MODE   : LED_out = 8'b0001_0000;
            LINE1        : LED_out = 8'b0000_1000;
            LINE2        : LED_out = 8'b0000_0100;
            DELAY_T      : LED_out = 8'b0000_0010;
            CLEAR_DISP   : LED_out = 8'b0000_0001;
        endcase
    end

    always @(negedge rst or posedge clk) begin
        if (!rst) begin
            e_en <= 1'b0;
            {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0000;
        end
        else begin
            e_en <= (state != DELAY);
            case (state)
                FUNCTION_SET : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0011_1000;
                DISP_ONOFF   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1100;
                ENTRY_MODE   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0110;
                LINE1        : if (cnt == 0)
                                   {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1000_0000;
                               else
                                   {LCD_RS, LCD_RW, LCD_DATA} <= {2'b10, TEXT1[8*(16-cnt) +: 8]};
                LINE2        : if (cnt == 0)
                                   {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1100_0000;
                               else
                                   {LCD_RS, LCD_RW, LCD_DATA} <= {2'b10, TEXT2[8*(16-cnt) +: 8]};
                DELAY_T      : if (cnt == 299)
                                   {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0001_1000;
                               else
                                   {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1100;
                CLEAR_DISP   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0001;
                default      : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0000;
            endcase
        end
    end

endmodule

module dac_display(
    input            clk,
    input            rst,
    input      [5:0] btn,
    input            add_sel,
    output           dac_csn,
    output           dac_ldacn,
    output           dac_wrn,
    output           dac_a_b,
    output     [7:0] dac_d,
    output     [7:0] led_out,
    output     [7:0] seg_data,
    output reg [7:0] seg_sel,
    output           LCD_E,
    output reg       LCD_RS,
    output reg       LCD_RW,
    output reg [7:0] LCD_DATA
    );

    parameter DELAY        = 3'b000;
    parameter FUNCTION_SET = 3'b001;
    parameter DISP_ONOFF   = 3'b010;
    parameter ENTRY_MODE   = 3'b011;
    parameter CLEAR_DISP   = 3'b100;
    parameter LINE1        = 3'b101;
    parameter LINE2        = 3'b110;

    reg  [2:0]   state;
    reg  [7:0]   cnt;
    reg          e_en;
    reg  [7:0]   lcd_d;
    reg          lcd_ab;
    reg  [3:0]   num;
    wire [3:0]   d2, d1, d0;
    wire [127:0] text1, text2;

    function [7:0] hex_char;
        input [3:0] h;
        hex_char = (h < 4'd10) ? 8'h30 + h : 8'h37 + h;
    endfunction

    dac         D1 (clk, rst, btn, add_sel, dac_csn, dac_ldacn, dac_wrn, dac_a_b, dac_d, led_out);
    seg_decoder S1 (num, seg_data);

    assign d2 = dac_d / 100;
    assign d1 = dac_d / 10 % 10;
    assign d0 = dac_d % 10;

    assign text1 = {"BIN ", 7'b0011000, lcd_d[7], 7'b0011000, lcd_d[6], 7'b0011000, lcd_d[5],
                    7'b0011000, lcd_d[4], 7'b0011000, lcd_d[3], 7'b0011000, lcd_d[2],
                    7'b0011000, lcd_d[1], 7'b0011000, lcd_d[0], " [", lcd_ab ? "B" : "A", "]"};
    assign text2 = {"DEC ", hex_char(lcd_d / 100), hex_char(lcd_d / 10 % 10), hex_char(lcd_d % 10), "  HEX ",
                    hex_char(lcd_d[7:4]), hex_char(lcd_d[3:0]), " "};

    always @(negedge rst or posedge clk) begin
        if (!rst)
            seg_sel <= 8'b11111110;
        else
            seg_sel <= {seg_sel[6:0], seg_sel[7]};
    end

    always @(*) begin
        case (seg_sel)
            8'b11111110 : num = d0;
            8'b11111101 : num = d1;
            8'b11111011 : num = d2;
            default     : num = 4'd15;
        endcase
    end

    assign LCD_E = clk & e_en;

    always @(negedge rst or posedge clk) begin
        if (!rst) begin
            lcd_d  <= 8'd0;
            lcd_ab <= 1'b0;
        end
        else if (state == LINE2 && cnt == 16) begin
            lcd_d  <= dac_d;
            lcd_ab <= dac_a_b;
        end
    end

    always @(negedge rst or posedge clk) begin
        if (!rst) begin
            state <= DELAY;
            cnt   <= 8'd0;
        end
        else begin
            cnt <= cnt + 1;
            case (state)
                DELAY        : if (cnt == 70) begin state <= FUNCTION_SET; cnt <= 0; end
                FUNCTION_SET : if (cnt == 30) begin state <= DISP_ONOFF;   cnt <= 0; end
                DISP_ONOFF   : if (cnt == 30) begin state <= ENTRY_MODE;   cnt <= 0; end
                ENTRY_MODE   : if (cnt == 30) begin state <= CLEAR_DISP;   cnt <= 0; end
                CLEAR_DISP   : if (cnt == 5)  begin state <= LINE1;        cnt <= 0; end
                LINE1        : if (cnt == 16) begin state <= LINE2;        cnt <= 0; end
                LINE2        : if (cnt == 16) begin state <= LINE1;        cnt <= 0; end
                default      : begin state <= DELAY; cnt <= 0; end
            endcase
        end
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
                CLEAR_DISP   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0001;
                LINE1        : if (cnt == 0)
                                   {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1000_0000;
                               else
                                   {LCD_RS, LCD_RW, LCD_DATA} <= {2'b10, text1[8*(16-cnt) +: 8]};
                LINE2        : if (cnt == 0)
                                   {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_1100_0000;
                               else
                                   {LCD_RS, LCD_RW, LCD_DATA} <= {2'b10, text2[8*(16-cnt) +: 8]};
                default      : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0000;
            endcase
        end
    end

endmodule

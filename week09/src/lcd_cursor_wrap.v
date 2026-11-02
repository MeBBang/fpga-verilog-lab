module lcd_cursor_wrap(
    input            rst,
    input            clk,
    output           LCD_E,
    output reg       LCD_RS,
    output reg       LCD_RW,
    output reg [7:0] LCD_DATA,
    output reg [7:0] LED_out,
    input      [9:0] number_btn,
    input      [1:0] control_btn,
    input            line_sel
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
    reg [6:0] addr;
    reg       line_q;
    reg       line_mv;

    wire [6:0] addr_inc = (addr == 7'h27) ? 7'h40 : ((addr == 7'h67) ? 7'h00 : addr + 1);
    wire [6:0] addr_dec = (addr == 7'h00) ? 7'h67 : ((addr == 7'h40) ? 7'h27 : addr - 1);
    wire       num_one  = (number_btn != 10'b0000_0000_00) && ((number_btn & (number_btn - 1)) == 10'b0000_0000_00);

    oneshot_universal #(.WIDTH(12)) O1 (clk, rst, {number_btn, control_btn}, {number_btn_t, control_btn_t});

    assign LCD_E = clk & e_en;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state   <= DELAY;
            LED_out <= 8'b0000_0000;
            line_q  <= 1'b0;
            line_mv <= 1'b0;
        end
        else begin
            case (state)
                DELAY        : begin if (cnt == 70)  state <= FUNCTION_SET; LED_out <= 8'b1000_0000; end
                FUNCTION_SET : begin if (cnt == 30)  state <= DISP_ONOFF;   LED_out <= 8'b0100_0000; end
                DISP_ONOFF   : begin if (cnt == 30)  state <= ENTRY_MODE;   LED_out <= 8'b0010_0000; end
                ENTRY_MODE   : begin if (cnt == 30)  state <= SET_ADDRESS;  LED_out <= 8'b0001_0000; end
                SET_ADDRESS  : begin if (cnt == 100) state <= DELAY_T;      LED_out <= 8'b0000_1000; end
                DELAY_T      : begin
                                   if (|number_btn_t)
                                       state <= WRITE;
                                   else if (|control_btn_t) begin
                                       state   <= CURSOR;
                                       line_mv <= 1'b0;
                                   end
                                   else if (line_sel != line_q) begin
                                       state   <= CURSOR;
                                       line_mv <= 1'b1;
                                       line_q  <= line_sel;
                                   end
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
            addr <= 7'h00;
            {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0001;
        end
        else begin
            e_en <= (state != DELAY);
            case (state)
                FUNCTION_SET : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0011_1000;
                DISP_ONOFF   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111;
                ENTRY_MODE   : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0110;
                SET_ADDRESS  : begin
                                   addr <= 7'h00;
                                   {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_0001;
                               end
                DELAY_T      : {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111;
                WRITE        : if (cnt == 20) begin
                                   if (num_one)
                                       addr <= addr_inc;
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
                               end
                               else
                                   {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111;
                CURSOR       : if (cnt == 20) begin
                                   if (line_mv) begin
                                       addr <= {line_q, addr[5:0]};
                                       {LCD_RS, LCD_RW, LCD_DATA} <= {2'b00, 1'b1, line_q, addr[5:0]};
                                   end
                                   else
                                       case (control_btn)
                                           2'b10 : begin
                                                       addr <= addr_dec;
                                                       {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0001_0000;
                                                   end
                                           2'b01 : if (addr[5:0] == 6'd15) begin
                                                       addr <= {addr[6], 6'd0};
                                                       {LCD_RS, LCD_RW, LCD_DATA} <= {2'b00, 1'b1, addr[6], 6'd0};
                                                   end
                                                   else begin
                                                       addr <= addr_inc;
                                                       {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0001_0100;
                                                   end
                                       endcase
                               end
                               else
                                   {LCD_RS, LCD_RW, LCD_DATA} <= 10'b0_0_0000_1111;
            endcase
        end
    end

endmodule

module tb_lcd_cursor;

    reg        rst, clk;
    reg  [9:0] number_btn;
    reg  [1:0] control_btn;
    wire       LCD_E, LCD_RS, LCD_RW;
    wire [7:0] LCD_DATA, LED_out;

    lcd_cursor uut (rst, clk, LCD_E, LCD_RS, LCD_RW, LCD_DATA, LED_out, number_btn, control_btn);

    always #500_000 clk = ~clk;

    initial begin
        clk         = 1'b0;
        rst         = 1'b0;
        number_btn  = 10'b0000_0000_00;
        control_btn = 2'b00;
        #1_000_000   rst         = 1'b1;
        #299_000_000 number_btn  = 10'b0100_0000_00;
        #50_000_000  number_btn  = 10'b0000_0000_00;
        #50_000_000  number_btn  = 10'b0000_1000_00;
        #50_000_000  number_btn  = 10'b0000_0000_00;
        #50_000_000  control_btn = 2'b10;
        #50_000_000  control_btn = 2'b00;
        #50_000_000  control_btn = 2'b01;
        #50_000_000  control_btn = 2'b00;
        #50_000_000  $finish;
    end

endmodule

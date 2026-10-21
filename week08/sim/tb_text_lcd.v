module tb_text_lcd;

    reg        clk, rst;
    wire       LCD_E, LCD_RS, LCD_RW;
    wire [7:0] LCD_DATA, LED_out;

    text_lcd uut (clk, rst, LCD_E, LCD_RS, LCD_RW, LCD_DATA, LED_out);

    always #500_000 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        #1_000_000   rst = 1'b1;
        #259_000_000 $finish;
    end

endmodule

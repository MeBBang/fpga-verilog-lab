module tb_vending_machine;

    reg        clk, rst, A, B, C;
    wire [2:0] state;
    wire       y;

    vending_machine uut (clk, rst, A, B, C, state, y);

    always #5 clk = ~clk;

    task press_A; begin #30 A = 1'b1; #30 A = 1'b0; end endtask
    task press_B; begin #30 B = 1'b1; #30 B = 1'b0; end endtask
    task press_C; begin #30 C = 1'b1; #30 C = 1'b0; end endtask

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        {A, B, C} = 3'b000;
        #20 rst = 1'b1;
        press_A;
        press_B;
        press_A;
        press_B;
        press_C;
        #10 rst = 1'b0;
        #20 rst = 1'b1;
        press_A;
        press_B;
        press_C;
        #30 $finish;
    end

endmodule

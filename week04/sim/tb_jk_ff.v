module tb_jk_ff;

    reg  j, k, clk;
    wire q;

    jk_ff uut (j, k, clk, q);

    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;
        {j, k} = 2'b00; #30;
        {j, k} = 2'b01; #30;
        {j, k} = 2'b00; #30;
        {j, k} = 2'b10; #30;
        {j, k} = 2'b00; #30;
        {j, k} = 2'b11; #30;
        {j, k} = 2'b00; #30;
        $finish;
    end

endmodule

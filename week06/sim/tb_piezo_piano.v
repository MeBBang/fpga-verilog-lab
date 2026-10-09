module tb_piezo_piano;

    reg        clk, rst;
    reg  [7:0] btn;
    wire       piezo;
    integer    i;

    piezo_piano uut (clk, rst, btn, piezo);

    always #500 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        btn = 8'b00000000;
        #5_000_000 rst = 1'b1;
        for (i = 0; i < 8; i = i + 1) begin
            #5_000_000  btn = 8'b00000001 << i;
            #20_000_000 btn = 8'b00000000;
        end
        #5_000_000 $finish;
    end

endmodule

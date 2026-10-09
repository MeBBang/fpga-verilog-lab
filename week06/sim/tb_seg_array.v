module tb_seg_array;

    reg        clk, rst, btn;
    wire [7:0] seg_data, seg_sel;

    seg_array uut (clk, rst, btn, seg_data, seg_sel);

    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        btn = 1'b0;
        #20 rst = 1'b1;
        repeat (17) begin
            #100 btn = 1'b1;
            #100 btn = 1'b0;
        end
        #100 $finish;
    end

endmodule

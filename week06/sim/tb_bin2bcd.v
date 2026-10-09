module tb_bin2bcd;

    reg  [3:0] bin;
    wire [7:0] bcd;

    bin2bcd uut (bin, bcd);

    initial begin
        bin = 4'd0;
        repeat (15) #20 bin = bin + 4'd1;
        #20 $finish;
    end

endmodule

module tb_comparator_4bit;

    reg  [3:0] a, b;
    wire       gt, eq, lt;

    comparator_4bit uut (a, b, gt, eq, lt);

    initial begin
        a = 4'b0011; b = 4'b1000; #100;
        a = 4'b0111; b = 4'b0001; #100;
        a = 4'b1001; b = 4'b1001; #100;
        a = 4'b1011; b = 4'b1111; #100;
        $finish;
    end

endmodule

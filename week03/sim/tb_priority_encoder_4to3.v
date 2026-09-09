module tb_priority_encoder_4to3;

    reg  [3:0] d;
    wire       x, y, v;

    priority_encoder_4to3 uut (d, x, y, v);

    initial begin
        d = 4'b0000; #100;
        d = 4'b1000; #100;
        d = 4'b1011; #100;
        d = 4'b0101; #100;
        d = 4'b0001; #100;
        $finish;
    end

endmodule

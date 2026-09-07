module tb_full_adder;

    reg  a, b, cin;
    wire cout, sum;
    integer i;

    full_adder uut (a, b, cin, cout, sum);

    initial begin
        for (i = 0; i < 8; i = i + 1) begin
            {a, b, cin} = i[2:0];
            #100;
        end
        $finish;
    end

endmodule

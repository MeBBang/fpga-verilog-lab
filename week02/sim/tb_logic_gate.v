module tb_logic_gate;

    reg  a, b;
    wire y_and, y_or, y_xor, y_nor, y_nand;
    integer i;

    logic_gate uut (a, b, y_and, y_or, y_xor, y_nor, y_nand);

    initial begin
        for (i = 0; i < 4; i = i + 1) begin
            {a, b} = i[1:0];
            #100;
        end
        $finish;
    end

endmodule

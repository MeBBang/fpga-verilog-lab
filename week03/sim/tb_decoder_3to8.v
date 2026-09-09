module tb_decoder_3to8;

    reg        x, y, z;
    wire [7:0] d;
    integer    i;

    decoder_3to8 uut (x, y, z, d);

    initial begin
        for (i = 0; i < 8; i = i + 1) begin
            {x, y, z} = i[2:0];
            #100;
        end
        $finish;
    end

endmodule

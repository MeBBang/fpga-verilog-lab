module tb_dac;

    reg        clk, rst;
    reg  [5:0] btn;
    reg        add_sel;
    wire       dac_csn, dac_ldacn, dac_wrn, dac_a_b;
    wire [7:0] dac_d, led_out;

    dac uut (clk, rst, btn, add_sel, dac_csn, dac_ldacn, dac_wrn, dac_a_b, dac_d, led_out);

    always #500 clk = ~clk;

    initial begin
        clk     = 1'b0;
        rst     = 1'b0;
        btn     = 6'b000000;
        add_sel = 1'b0;
        #1_000   rst     = 1'b1;
        #299_000 btn     = 6'b000001;
        #50_000  btn     = 6'b000000;
        #250_000 btn     = 6'b000100;
        #50_000  btn     = 6'b000000;
        #250_000 btn     = 6'b010000;
        #50_000  btn     = 6'b000000;
        #250_000 btn     = 6'b100000;
        #50_000  btn     = 6'b000000;
        #250_000 btn     = 6'b001000;
        #50_000  btn     = 6'b000000;
        #250_000 btn     = 6'b000010;
        #50_000  btn     = 6'b000000;
        #150_000 add_sel = 1'b1;
        #100_000 btn     = 6'b100000;
        #50_000  btn     = 6'b000000;
        #250_000 $finish;
    end

endmodule

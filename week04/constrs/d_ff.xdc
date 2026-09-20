set_property -dict {PACKAGE_PIN Y1 IOSTANDARD LVCMOS33} [get_ports d]
set_property -dict {PACKAGE_PIN K4 IOSTANDARD LVCMOS33} [get_ports clk]

set_property -dict {PACKAGE_PIN L4 IOSTANDARD LVCMOS33} [get_ports q]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]

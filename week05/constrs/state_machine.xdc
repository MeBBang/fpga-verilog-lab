set_property -dict {PACKAGE_PIN Y1 IOSTANDARD LVCMOS33} [get_ports rst]
set_property -dict {PACKAGE_PIN W3 IOSTANDARD LVCMOS33} [get_ports x]
set_property -dict {PACKAGE_PIN K4 IOSTANDARD LVCMOS33} [get_ports clk]

set_property -dict {PACKAGE_PIN L4 IOSTANDARD LVCMOS33} [get_ports {state[1]}]
set_property -dict {PACKAGE_PIN M4 IOSTANDARD LVCMOS33} [get_ports {state[0]}]
set_property -dict {PACKAGE_PIN N5 IOSTANDARD LVCMOS33} [get_ports y]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]

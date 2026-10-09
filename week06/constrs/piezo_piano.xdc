set_property -dict {PACKAGE_PIN Y1 IOSTANDARD LVCMOS33} [get_ports rst]
set_property -dict {PACKAGE_PIN B6 IOSTANDARD LVCMOS33} [get_ports clk]

set_property -dict {PACKAGE_PIN K4 IOSTANDARD LVCMOS33} [get_ports {btn[0]}]
set_property -dict {PACKAGE_PIN N8 IOSTANDARD LVCMOS33} [get_ports {btn[1]}]
set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVCMOS33} [get_ports {btn[2]}]
set_property -dict {PACKAGE_PIN N1 IOSTANDARD LVCMOS33} [get_ports {btn[3]}]
set_property -dict {PACKAGE_PIN P6 IOSTANDARD LVCMOS33} [get_ports {btn[4]}]
set_property -dict {PACKAGE_PIN N6 IOSTANDARD LVCMOS33} [get_ports {btn[5]}]
set_property -dict {PACKAGE_PIN L5 IOSTANDARD LVCMOS33} [get_ports {btn[6]}]
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports {btn[7]}]

set_property -dict {PACKAGE_PIN Y21 IOSTANDARD LVCMOS33} [get_ports piezo]

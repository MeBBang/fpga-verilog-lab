set_property -dict {PACKAGE_PIN Y1 IOSTANDARD LVCMOS33} [get_ports {a[3]}]
set_property -dict {PACKAGE_PIN W3 IOSTANDARD LVCMOS33} [get_ports {a[2]}]
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {a[1]}]
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports {a[0]}]

set_property -dict {PACKAGE_PIN W4 IOSTANDARD LVCMOS33} [get_ports {b[3]}]
set_property -dict {PACKAGE_PIN W1 IOSTANDARD LVCMOS33} [get_ports {b[2]}]
set_property -dict {PACKAGE_PIN V4 IOSTANDARD LVCMOS33} [get_ports {b[1]}]
set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS33} [get_ports {b[0]}]

set_property -dict {PACKAGE_PIN L4 IOSTANDARD LVCMOS33} [get_ports gt]
set_property -dict {PACKAGE_PIN M4 IOSTANDARD LVCMOS33} [get_ports eq]
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS33} [get_ports lt]

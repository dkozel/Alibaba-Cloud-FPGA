# The IO standard and pad was taken from https://github.com/TiferKing/as02mc04_hack/blob/main/as02mc04/1.0/part0_pins.xml
# Enabled a pull-up since done for a different design.
set_false_path -from [get_ports PCI_PERSTN]
set_property PULLTYPE PULLUP [get_ports PCI_PERSTN]
set_property IOSTANDARD LVCMOS18 [get_ports PCI_PERSTN]
set_property PACKAGE_PIN A9 [get_ports PCI_PERSTN]

# Pins taken from https://github.com/TiferKing/as02mc04_hack/blob/main/as02mc04/1.0/part0_pins.xml
set_property PACKAGE_PIN T7 [get_ports {CLK_PCIe_100MHz_clk_p[0]}]
create_clock -name {CLK_PCIe_100MHz_clk_p[0]} -period 10.00 [get_ports {CLK_PCIe_100MHz_clk_p[0]}]
set_property PACKAGE_PIN P2 [get_ports {pcie_7x_mgt_rxp[0]}]
set_property PACKAGE_PIN T2 [get_ports {pcie_7x_mgt_rxp[1]}]
set_property PACKAGE_PIN V2 [get_ports {pcie_7x_mgt_rxp[2]}]
set_property PACKAGE_PIN Y2 [get_ports {pcie_7x_mgt_rxp[3]}]
set_property PACKAGE_PIN AB2 [get_ports {pcie_7x_mgt_rxp[4]}]
set_property PACKAGE_PIN AD2 [get_ports {pcie_7x_mgt_rxp[5]}]
set_property PACKAGE_PIN AE4 [get_ports {pcie_7x_mgt_rxp[6]}]
set_property PACKAGE_PIN AF2 [get_ports {pcie_7x_mgt_rxp[7]}]


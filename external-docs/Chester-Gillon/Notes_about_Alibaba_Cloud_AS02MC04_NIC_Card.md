## 0. Introduction

This contains notes about using the [Xilinx FPGA development Kintex ku3p ultra scale + development XCKU3P-FFVB676](https://www.ebay.com/itm/167626831054). The branding is _Alibaba Cloud_ with part number AS02MC04.

Read the _Device DNA_ over JTAG and using [AMD Device Lookup](https://2dbarcode.xilinx.com/scan) reports:
<table>
  <tr><td><b>Device</b></td><td>XCKU3P</td></tr>
  <tr><td><b>Package-Pin</b></td><td>FFVB676</td></tr>
  <tr><td><b>Revision Code</b></td><td>AAZ</td></tr>
  <tr><td><b>SpeedGrade</b></td><td>1E</td></tr>
</table>

## 1. Reference information

The results of searching for information on AS02MC04.

## 1.1. github project as02mc04_hack

[as02mc04_hack](https://github.com/TiferKing/as02mc04_hack) is a github project with some board files.

The part specified in the project is `xcku3p-ffvb676-2-e`, which a faster speed grade 2E than the 1E read via DNA.

The translation of the readme in the project has a title of _AS02MC04 Board Reverse Engineering Data_ which is perhaps why the speed grade is wrong in the project. Not sure if different boards have different speed grade parts fitted.

## 1.2. Tutorials from _Domi fruit_

- [Low-cost, high-performance FPGA development tool: XiaoAli board AS02MC04 complete development tutorial [Part 1] - Exploring the unlimited potential of Xilinx Kintex UltraScale+ FPGA](https://zhuanlan.zhihu.com/p/24657498989) This has some images of pin out tables.
- [AS02MC04 Development Tutorial for XiaoAli Board [Part 2] - Clock and LED Configuration and Flash Loading Configuration](https://zhuanlan.zhihu.com/p/25813982411) This has some constraints as text. The QSPI is given as MT25QU256, which is the same base part number as used on [Notes about XCKU5P PCIE 3.0 QSFP X2](https://gist.github.com/Chester-Gillon/ba675c6ab4e5eb7271f43f8ce4aedb6c)
- [Xiao Ali Board AS02MC04 Development Tutorial [Part 3] - PCIE 3.0 x8 Interface Development and Speed Test Verification](https://zhuanlan.zhihu.com/p/26890429797) This doesn't contain any additional pin out information.

A copy of the constraints is:
```tcl
set_property PACKAGE_PIN B11 [get_ports {LED[0]}]
set_property PACKAGE_PIN C11 [get_ports {LED[1]}]
set_property PACKAGE_PIN A10 [get_ports {LED[2]}]
set_property PACKAGE_PIN B10 [get_ports {LED[3]}]
set_property PACKAGE_PIN E18 [get_ports diff_100mhz_clk_p]
set_property IOSTANDARD LVDS [get_ports diff_100mhz_clk_p]
set_property IOSTANDARD LVDS [get_ports diff_100mhz_clk_n]
set_property PACKAGE_PIN A12 [get_ports LED_G]
set_property PACKAGE_PIN A13 [get_ports LED_R]
set_property PACKAGE_PIN B9 [get_ports LED_HEART]
set_property PACKAGE_PIN B12 [get_ports SFP_1_LED]
set_property PACKAGE_PIN C12 [get_ports SFP_2_LED]
#set_property PACKAGE_PIN K7 [get_ports sfp_mgt_clk_p]
set_property PACKAGE_PIN F12 [get_ports SW_RESET]
set_property IOSTANDARD LVCMOS18 [get_ports {LED[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {LED[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {LED[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {LED[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports LED_G]
set_property IOSTANDARD LVCMOS18 [get_ports LED_HEART]
set_property IOSTANDARD LVCMOS18 [get_ports LED_R]
set_property IOSTANDARD LVCMOS18 [get_ports SW_RESET]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_1_LED]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_2_LED]

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 31.9 [current_design]
```

## 2. QSPI

The QSPI has Micron _FBGA Code_ `RW170`, which is Part Number [MT25QU256ABA8ESF-0SIT](https://www.micron.com/products/storage/nor-flash/serial-nor/part-catalog/part-detail/mt25qu256aba8esf-0sit)

Parsing the configuration bitstream read via a FPGA design:
```
$ xilinx_quad_spi/quad_spi_flasher 
Opening device 0000:01:00.0 (10ee:9038) with IOMMU group 0
Enabled bus master for 0000:01:00.0
Warning: Device device 0000:01:00.0 (10ee:9038) has reduced bandwidth
         Max width x8 speed 8 GT/s. Negotiated width x8 speed 2.5 GT/s

Displaying information for SPI flash using AS02MC04_dma_stream_crc64 design in PCI device 0000:01:00.0 IOMMU group 0
FIFO depth=256
Flash device : Micron N25Q256A
Manufacturer ID=0x20  Memory Interface Type=0xbb  Density=0x19
Flash Size Bytes=33554432  Page Size Bytes=256  Num Address Bytes=4
Successfully parsed bitstream of length 12603672 bytes with 159333 configuration packets
Read 12615680 bytes from SPI flash starting at address 0
Sync word at byte index 0x50
  Type 1 packet opcode NOP
  Type 1 packet opcode write register BSPI words 0000066C
  Type 1 packet opcode write register CMD command BSPI_READ
  Type 1 packet opcode NOP (2 consecutive)
  Type 1 packet opcode write register TIMER words 00000000
  Type 1 packet opcode write register WBSTAR words 00000000
  Type 1 packet opcode write register CMD command NULL
  Type 1 packet opcode NOP
  Type 1 packet opcode write register CMD command RCRC
  Type 1 packet opcode NOP (2 consecutive)
  Type 1 packet opcode write register FAR words 00000000
  Type 1 packet opcode write register RBCRC_SW words 00000000
  Type 1 packet opcode write register COR0 words 38083FE5
  Type 1 packet opcode write register COR1 words 00400000
  Type 1 packet opcode write register IDCODE KU3P
  Type 1 packet opcode write register CMD command FALL_EDGE
  Type 1 packet opcode write register CMD command SWITCH
  Type 1 packet opcode NOP
  Type 1 packet opcode write register MASK words 00000001
  Type 1 packet opcode write register CTL0 words 00000101
  Type 1 packet opcode write register MASK words 00001000
  Type 1 packet opcode write register CTL1 words 00001000
  Type 1 packet opcode NOP (8 consecutive)
  Configuration data writes consisting of:
    134708 NOPs
    11794 FAR writes
    318 WCFG commands
    318 FDRI writes with a total of 61752 words
    58 MFW commands
    58 NULL commands
    11476 MFWR writes with a total of 160664 words
    140 Type 2 packets with a total of 2756892 words
  Type 1 packet opcode write register CRC words EEFE3AE6
  Type 1 packet opcode NOP (2 consecutive)
  Type 1 packet opcode write register CMD command GRESTORE
  Type 1 packet opcode NOP (2 consecutive)
  Type 1 packet opcode write register CMD command DGHIGH_LFRM
  Type 1 packet opcode NOP (20 consecutive)
  Type 1 packet opcode write register MASK words 00001000
  Type 1 packet opcode write register CTL1 words 00000000
  Type 1 packet opcode write register CMD command START
  Type 1 packet opcode NOP
  Type 1 packet opcode write register FAR words 07FC0000
  Type 1 packet opcode write register MASK words 00000101
  Type 1 packet opcode write register CTL0 words 00000101
  Type 1 packet opcode write register CRC words 5FFE959E
  Type 1 packet opcode NOP (2 consecutive)
  Type 1 packet opcode write register CMD command DESYNC
  Type 1 packet opcode NOP (393 consecutive)
```

## 3. First attempt at PCIe design

This uses the AS02MC04_dma_stream_crc64 design

## 3.1. HP Pavilion 590-p0053na desktop

The design failed to enumerate on the PCIe bus, over multiple attempts.

Enabled the JTAG debugger in the DMA bridge IP. Failed to obtain any conclusive reason for the failure to enumerate. Sometimes `source AS02MC04_dma_stream_crc64/AS02MC04_dma_stream_crc64.gen/sources_1/bd/AS02MC04_dma_stream_crc64/ip/AS02MC04_dma_stream_crc64_xdma_0_0/ip_0/AS02MC04_dma_stream_crc64_xdma_0_0_pcie4_ip/pcie_debugger/test_rd.tcl` would result in a AXI timeout being reported (didn't record the exact error).

## 3.2. Intel DH67BL motherboard

An Intel DH67BL motherboard with a i5-2310 CPU. Running AlmaLinux 8.10.

The same FPGA design which failed to enumerate in the HP Pavilion 590-p0053na didn't enumerate in this PC.

As per [AS02MC04_dma_stream_crc64](https://gist.github.com/Chester-Gillon/cf17eb97c63e754de4e06bc6552ffdb7#22--as02mc04_dma_stream_crc64) in this PC after a VFIO open the link speed trains at 2.5 GT/s rather than the expected 5 GT/s supported by the PC. Same issue as seen with other FPGA boards in the same PC.

Haven't seen `pcie_debugger/test_rd.tcl` fail with a timeout.

## 4. PCIe enumeration issues

Describes issues with trying to get the PCIe endpoint to enumerate as Gen3 speed x8 width, using the AS02MC04_dma_stream_crc64 design based upon _DMA/Bridge Subsystem for PCI Express (4.2)_

## 4.1. PCIe lane constraints using examples

Started with the following constaints, which match [part0_pins.xml](https://github.com/TiferKing/as02mc04_hack/blob/main/as02mc04/1.0/part0_pins.xml):
```tcl
set_property PACKAGE_PIN P2 [get_ports {pcie_7x_mgt_rxp[0]}]
set_property PACKAGE_PIN T2 [get_ports {pcie_7x_mgt_rxp[1]}]
set_property PACKAGE_PIN V2 [get_ports {pcie_7x_mgt_rxp[2]}]
set_property PACKAGE_PIN Y2 [get_ports {pcie_7x_mgt_rxp[3]}]
set_property PACKAGE_PIN AB2 [get_ports {pcie_7x_mgt_rxp[4]}]
set_property PACKAGE_PIN AD2 [get_ports {pcie_7x_mgt_rxp[5]}]
set_property PACKAGE_PIN AE4 [get_ports {pcie_7x_mgt_rxp[6]}]
set_property PACKAGE_PIN AF2 [get_ports {pcie_7x_mgt_rxp[7]}]
```

## 4.1.1. HP Pavilion 590-p0053na desktop x16 PCIe slot

This failed to enumerate

## 4.1.2. Intel DH67BL motherboard

An Intel DH67BL motherboard with a i5-2310 CPU.

This enumerated at x8 width. The speed was Gen1 but could be re-trained to Gen2 which is the fastest supported by the CPI.

## 4.1.3. HP Z6 G4 Slot 4

This enumerated at Gen 3 x4 width.

The slot is x8 width when SSD1 isn't fitted, and the BIOS indicates supports bifurcation as either x8 or x4x4.

Changing the BIOS bifurcation from Auto to x8 still resulted in enumeration at x4 width.

## 4.1.4. HP Z6 G4 Slot 2

This failed to enumerate.

The slot is Gen3 x16.

## 4.1.5. HP Z4 G4 Slot 5

This failed to enumerate.

The slot is Gen3 x8, and the BIOS indicates supports bifurcation as either x8 or x4x4.

## 4.2. Reversing lanes in constraints

Rebuilt the AS02MC04_dma_stream_crc64 with modified constraints to reverse all 8 lanes at the FPGA pins, compared to reversed engineered examples. I.e. used:
```tcl
set_property PACKAGE_PIN P2 [get_ports {pcie_7x_mgt_rxp[7]}]
set_property PACKAGE_PIN T2 [get_ports {pcie_7x_mgt_rxp[6]}]
set_property PACKAGE_PIN V2 [get_ports {pcie_7x_mgt_rxp[5]}]
set_property PACKAGE_PIN Y2 [get_ports {pcie_7x_mgt_rxp[4]}]
set_property PACKAGE_PIN AB2 [get_ports {pcie_7x_mgt_rxp[3]}]
set_property PACKAGE_PIN AD2 [get_ports {pcie_7x_mgt_rxp[2]}]
set_property PACKAGE_PIN AE4 [get_ports {pcie_7x_mgt_rxp[1]}]
set_property PACKAGE_PIN AF2 [get_ports {pcie_7x_mgt_rxp[0]}]
```
With the board fitted into HP Z4 G4 slot switching between two bitstreams repeatidly resulted in:
1. With the original lane mapping, did not enumerate
2. With the reversed lane mapping, enumerated at x4 width.

When has enumerated with the reversed lane mapping:
```
[mr_halfword@skylake-alma release]$ identify_pcie_fpga_design/display_identified_pcie_fpga_designs -d 0000:2d:00.0
Opening device 0000:2d:00.0 (10ee:9038) with IOMMU group 25
Enabled bus master for 0000:2d:00.0
Warning: Device device 0000:2d:00.0 (10ee:9038) has reduced bandwidth
         Max width x8 speed 8 GT/s. Negotiated width x4 speed 8 GT/s

Design AS02MC04_dma_stream_crc64:
  PCI device 0000:2d:00.0 rev 00 IOMMU group 25  physical slot 5-2

  DMA bridge bar 2 AXI Stream
  Channel ID  addr_alignment  len_granularity  num_address_bits
       H2C 0               1                1                64
       H2C 1               1                1                64
       H2C 2               1                1                64
       H2C 3               1                1                64
       C2H 0               1                1                64
       C2H 1               1                1                64
       C2H 2               1                1                64
       C2H 3               1                1                64
  User access build timestamp : 14332B0F - 02/08/2025 18:44:15
  Quad SPI registers at bar 0 offset 0x0
  SYSMON registers at bar 0 offset 0x1000
```
[Lane Reversal](https://docs.amd.com/r/en-US/pg213-pcie4-ultrascale-plus/Lane-Reversal) in the _UltraScale+ Devices Integrated Block for PCI Express Product Guide (PG213)_ says when lane reversal is supported.

## 4.3. Investigation into different FPGA configurations - when configuration memory had design which fails to enumerate

This uses the board in the HP Z4 G4 slot 5.

In the BIOS PCIe related settings are the following:
 - System Options -> PCIe Training Reset -> Enable (default was Disable, had enabled it during a previous test)
 - Slot Settings -> Slot 5 PCI Express x8
   - Option ROM Download -> Enable
   - Limit PCIe Speed -> Auto
   - Bifurcation -> Auto
   - Resizable Bars -> Disable

Due to [Windows 11 not booting after update to 24H2](https://gist.github.com/Chester-Gillon/5b09a5c0609aded0ff93faaa14724158) can't boot into Windows to run the tool which saves all settings to a file, and therefore the above settings were checked in the BIOS GUI.

Had previously used the Windows utility to enable hot-plug support on slot 5, which is a setting which isn't visible in the BIOS GUI.

## 4.3.1. Modified AS02MC04_dma_stream_crc64 in configuration memory

The configurarion memory of the FPGA is from a version of AS02MC04_dma_stream_crc64 with local modifications not under GIT control:
- The red, rather than green, board edge LED indicates the PCIe link is up. That is easier to see as other LEDs on the board are gree.
- The lanes are reversed in the constraints

At power up at PCIe link doesn't come up. There are two root ports, with physical slots `5` and `5-1`:
```
$ dump_info/display_physical_slots 
Access method : linux-sysfs
domain=0000 bus=15 dev=00 func=00
  vendor_id=10ee (Xilinx Corporation) device_id=7024 (Device 7024)
  physical slot: 3-1
domain=0000 bus=2c dev=02 func=00
  vendor_id=8086 (Intel Corporation) device_id=2032 (Sky Lake-E PCI Express Root Port C)
  physical slot: 6
domain=0000 bus=00 dev=1d func=00
  vendor_id=8086 (Intel Corporation) device_id=a298 (200 Series PCH PCI Express Root Port #9)
  physical slot: 4
domain=0000 bus=2c dev=03 func=00
  vendor_id=8086 (Intel Corporation) device_id=2033 (Sky Lake-E PCI Express Root Port D)
  physical slot: 7
domain=0000 bus=2c dev=00 func=00
  vendor_id=8086 (Intel Corporation) device_id=2030 (Sky Lake-E PCI Express Root Port A)
  physical slot: 5
domain=0000 bus=00 dev=1b func=00
  vendor_id=8086 (Intel Corporation) device_id=a2eb (200 Series PCH PCI Express Root Port #21)
  physical slot: 8191
domain=0000 bus=2c dev=01 func=00
  vendor_id=8086 (Intel Corporation) device_id=2031 (Sky Lake-E PCI Express Root Port B)
  physical slot: 5-1
domain=0000 bus=37 dev=00 func=00
  vendor_id=10ee (Xilinx Corporation) device_id=7011 (7-Series FPGA Hard PCIe block (AXI/debug))
  physical slot: 6-1
domain=0000 bus=14 dev=00 func=00
  vendor_id=8086 (Intel Corporation) device_id=2030 (Sky Lake-E PCI Express Root Port A)
  physical slot: 3
domain=0000 bus=20 dev=00 func=00
  vendor_id=8086 (Intel Corporation) device_id=2030 (Sky Lake-E PCI Express Root Port A)
  physical slot: 1
```
Both root ports for slots `5` and `5-1` have a x4 width.

If boot the FPGA from the configuration memory when Linux is booted the link comes up, as x4 on physical slot `5-2`:
```
$ identify_pcie_fpga_design/display_identified_pcie_fpga_designs 
Opening device 0000:15:00.0 (10ee:7024) with IOMMU group 41
Enabled bus master for 0000:15:00.0
Opening device 0000:2d:00.0 (10ee:9038) with IOMMU group 25
Enabled bus master for 0000:2d:00.0
Warning: Device device 0000:2d:00.0 (10ee:9038) has reduced bandwidth
         Max width x8 speed 8 GT/s. Negotiated width x4 speed 8 GT/s
Opening device 0000:37:00.0 (10ee:7011) with IOMMU group 86
Enabled bus master for 0000:37:00.0

Design dma_blkram (TEF1001):
  PCI device 0000:15:00.0 rev 00 IOMMU group 41  physical slot 3-1

  DMA bridge bar 0 memory size 0x120000
  Channel ID  addr_alignment  len_granularity  num_address_bits
       H2C 0               1                1                64
       H2C 1               1                1                64
       C2H 0               1                1                64
       C2H 1               1                1                64

Design AS02MC04_dma_stream_crc64:
  PCI device 0000:2d:00.0 rev 00 IOMMU group 25  physical slot 5-2

  DMA bridge bar 2 AXI Stream
  Channel ID  addr_alignment  len_granularity  num_address_bits
       H2C 0               1                1                64
       H2C 1               1                1                64
       H2C 2               1                1                64
       H2C 3               1                1                64
       C2H 0               1                1                64
       C2H 1               1                1                64
       C2H 2               1                1                64
       C2H 3               1                1                64
  User access build timestamp : 14332B0F - 02/08/2025 18:44:15
  Quad SPI registers at bar 0 offset 0x0
  SYSMON registers at bar 0 offset 0x1000

Design Nitefury Project-0 version 0x2:
  PCI device 0000:37:00.0 rev 00 IOMMU group 86  physical slot 6-1

  DMA bridge bar 2 memory size 0x40000000
  Channel ID  addr_alignment  len_granularity  num_address_bits
       H2C 0               1                1                64
       C2H 0               1                1                64
  Quad SPI registers at bar 0 offset 0x10000
  XADC registers at bar 0 offset 0x3000
```
The results:
```
$ xilinx_dma_bridge_for_pcie/crc64_stream_latency -t
Opening device 0000:15:00.0 (10ee:7024) with IOMMU group 41
Enabled bus master for 0000:15:00.0
Opening device 0000:2d:00.0 (10ee:9038) with IOMMU group 25
Enabled bus master for 0000:2d:00.0
Warning: Device device 0000:2d:00.0 (10ee:9038) has reduced bandwidth
         Max width x8 speed 8 GT/s. Negotiated width x4 speed 8 GT/s
Opening device 0000:37:00.0 (10ee:7011) with IOMMU group 86
Enabled bus master for 0000:37:00.0
Testing design AS02MC04_dma_stream_crc64 using C2H 0 -> H2C 0
Current temperature  41.3C  min  39.3C  max  44.3C
     32 len bytes latencies (us):   2.642 (50')   2.780 (75')   3.258 (99')  18.868 (99.999')
     64 len bytes latencies (us):   2.619 (50')   2.624 (75')   2.645 (99')  13.076 (99.999')
    128 len bytes latencies (us):   2.653 (50')   2.662 (75')   2.683 (99')  18.028 (99.999')
    256 len bytes latencies (us):   2.724 (50')   2.733 (75')   2.754 (99')  11.898 (99.999')
    512 len bytes latencies (us):   2.832 (50')   2.840 (75')   2.865 (99')  13.051 (99.999')
   1024 len bytes latencies (us):   2.974 (50')   2.981 (75')   3.008 (99')  18.005 (99.999')
   2048 len bytes latencies (us):   3.263 (50')   3.276 (75')   3.310 (99')  17.748 (99.999')
   4096 len bytes latencies (us):   3.861 (50')   3.872 (75')   3.905 (99')  19.126 (99.999')
   8192 len bytes latencies (us):   4.986 (50')   5.000 (75')   5.034 (99')  20.762 (99.999')
  16384 len bytes latencies (us):   7.297 (50')   7.310 (75')   7.339 (99')  23.028 (99.999')
  32768 len bytes latencies (us):  12.014 (50')  12.043 (75')  12.387 (99')  25.745 (99.999')
  65536 len bytes latencies (us):  21.370 (50')  21.419 (75')  21.729 (99')  38.491 (99.999')
 131072 len bytes latencies (us):  40.062 (50')  40.090 (75')  40.548 (99')  55.257 (99.999')
 262144 len bytes latencies (us):  77.365 (50')  77.421 (75')  77.838 (99')  92.264 (99.999')
 524288 len bytes latencies (us): 152.354 (50') 152.530 (75') 152.675 (99') 166.228 (99.999')
1048576 len bytes latencies (us): 301.333 (50') 301.380 (75') 301.905 (99') 315.720 (99.999')
Current temperature  41.3C  min  39.3C  max  45.3C
```
When reboot the link goes down and doesn't come back up.

## 4.3.2 gen3_x8_example_lane_order

This doesn't enumerate, neither after loading over JTAG nor after a subsequent reboot.

## 4.3.3. gen3_x8_reversed_lane_order

This enumerates after loading over JTAG, as x4 width on physical slot 5-2.

If reboot with the design loaded, the link goes down and doesn't come up at reboot.

After downgrading from v2025.1 to v2024.2 to enable the JTAG debugger in XDMA and avoid the issue in [2.3. Investigating JTAG debugger](https://gist.github.com/Chester-Gillon/0cd96b77ae400ba2eb45745e640f1f5f#23-investigating-jtag-debugger) with the JTAG debugger not working, this still enumerated as a x4 width on physical slot 5-2:
```
$ identify_pcie_fpga_design/display_identified_pcie_fpga_designs 
Opening device 0000:2d:00.0 (10ee:9038) with IOMMU group 26
Enabled bus master for 0000:2d:00.0
Warning: Device device 0000:2d:00.0 (10ee:9038) has reduced bandwidth
         Max width x8 speed 8 GT/s. Negotiated width x4 speed 8 GT/s
Opening device 0000:37:00.0 (10ee:7011) with IOMMU group 86
Enabled bus master for 0000:37:00.0

Design AS02MC04_enum:
  PCI device 0000:2d:00.0 rev 01 IOMMU group 26  physical slot 5-2

  DMA bridge bar 1 memory size 0x1000
  Channel ID  addr_alignment  len_granularity  num_address_bits
       H2C 0               1                1                64
       C2H 0               1                1                64
  User access build timestamp : FC334B0A - 31/08/2025 20:44:10

Design Nitefury Project-0 version 0x2:
  PCI device 0000:37:00.0 rev 00 IOMMU group 86  physical slot 6-1

  DMA bridge bar 2 memory size 0x40000000
  Channel ID  addr_alignment  len_granularity  num_address_bits
       H2C 0               1                1                64
       C2H 0               1                1                64
  Quad SPI registers at bar 0 offset 0x10000
  XADC registers at bar 0 offset 0x3000
```
The `test_rd.tcl` script ran:
```
source -notrace AS02MC04_enum/AS02MC04_enum.gen/sources_1/bd/AS02MC04_enum/ip/AS02MC04_enum_xdma_0_0/ip_0/AS02MC04_enum_xdma_0_0_pcie4_ip/pcie_debugger/test_rd.tcl
Identified PCIe debugger with hw_axi_1
INFO: [Labtoolstcl 44-481] READ DATA is: 00000901
INFO: [Labtoolstcl 44-481] READ DATA is: 00000001
INFO: [Labtoolstcl 44-481] READ DATA is: 00000009
INFO: [Labtoolstcl 44-481] READ DATA is: 00000000
INFO: [Labtoolstcl 44-481] READ DATA is: 00000000
INFO: [Labtoolstcl 44-481] READ DATA is: 00001001
INFO: [Labtoolstcl 44-481] READ DATA is: 0000abcd
INFO: [Labtoolstcl 44-481] READ DATA is: 00000000
phy_lane : 8
width : 04
speed : 03
```
`draw_rxdet.tcl` indicated a receiver was detected in all 8 lanes:
```
$ wish AS02MC04_enum/AS02MC04_enum.gen/sources_1/bd/AS02MC04_enum/ip/AS02MC04_enum_xdma_0_0/ip_0/AS02MC04_enum_xdma_0_0_pcie4_ip/pcie_debugger/draw_rxdet.tcl 
phy_lane : 8
width :  4
speed : 03
count = 1
 i = 0
count = 2
 i = 0
line1 = 13
Receiver detected in lane 0
count = 3
 i = 0
Receiver detected in lane 0
count = 4
 i = 0
Receiver detected in lane 0
count = 5
 i = 4
count = 6
 i = 4
line1 = 13
Receiver detected in lane 1
count = 7
 i = 4
Receiver detected in lane 1
count = 8
 i = 4
Receiver detected in lane 1
count = 9
 i = 8
count = 10
 i = 8
line1 = 13
Receiver detected in lane 2
count = 11
 i = 8
Receiver detected in lane 2
count = 12
 i = 8
Receiver detected in lane 2
count = 13
 i = 12
count = 14
 i = 12
line1 = 13
Receiver detected in lane 3
count = 15
 i = 12
Receiver detected in lane 3
count = 16
 i = 12
Receiver detected in lane 3
count = 17
 i = 16
count = 18
 i = 16
line1 = 13
Receiver detected in lane 4
count = 19
 i = 16
Receiver detected in lane 4
count = 20
 i = 16
Receiver detected in lane 4
count = 21
 i = 20
count = 22
 i = 20
line1 = 13
Receiver detected in lane 5
count = 23
 i = 20
Receiver detected in lane 5
count = 24
 i = 20
Receiver detected in lane 5
count = 25
 i = 24
count = 26
 i = 24
line1 = 13
Receiver detected in lane 6
count = 27
 i = 24
Receiver detected in lane 6
count = 28
 i = 24
Receiver detected in lane 6
count = 29
 i = 28
count = 30
 i = 28
line1 = 13
Receiver detected in lane 7
count = 31
 i = 28
Receiver detected in lane 7
count = 32
 i = 28
Receiver detected in lane 7
```

<img width="425" height="779" alt="image" src="https://gist.github.com/user-attachments/assets/f95f1922-639a-47ab-a931-4768cb9244e3" />

Output from `draw_reset.tcl`:

<img width="619" height="776" alt="image" src="https://gist.github.com/user-attachments/assets/f03b72d1-4086-458e-90a1-0f7aa9734b66" />

Output from `draw_ltssm.tcl`:

<img width="1391" height="816" alt="image" src="https://gist.github.com/user-attachments/assets/70ebd920-1a89-4dcc-8d78-e3fa50ca69aa" />


## 4.3.4. gen3_x4_quad224_example_order

This enumerated after loading over JTAG, as x4 width on physical slot 5-2.

If reboot with the design loaded, the link goes down and then back up about one second later.

## 4.3.5. gen3_x4_quad224_reversed_lane_order

This enumerated after loading over JTAG, as x4 width on physical slot 5-2.

If reboot with the design loaded, the link goes down and then back up about one second later.

## 4.3.6. gen3_x4_quad225_example_order

With the previous gen3_x4_quad224_reversed_lane_order loaded, loaded gen3_x4_quad225_example_order and the link went down and didn't come back up.

After a reboot the link came up as x4 width with no physical slot set.

## 4.3.7. gen3_x4_quad225_reversed_lane_order

With the previous gen3_x4_quad225_example_order, laded gen3_x4_quad225_reversed_lane_order and the link went down and the PC rebooted itself a short time later. Following the reboot the link came up as x4 width with no physical slot set.

## 4.4. Investigation into different FPGA configurations - after erasing configuration memory

Since the configuration memory had a design which didn't enumerate at power up, could have been causing the BIOS to set endup with a x4x4 bifurcation. Therefore, investigate erasing the configuration memory.

## 4.4.1. Initial erase left what looks like a fallback image

With the Vivado Hardware Manager erased the configuration memory with Address Range at the default of _Configuration File Only_. The Vivado Tcl Console report the erease and blank check was successful:
```
program_hw_cfgmem -hw_cfgmem [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xcku3p_0] 0]]
Mfg ID : 20   Memory Type : bb   Memory Capacity : 19   Device ID 1 : 0   Device ID 2 : 0
Performing Erase Operation...
Erase Operation successful.
Performing Blank Check Operation...
Blank Check Operation successful. The part is blank.
INFO: [Labtoolstcl 44-377] Flash programming completed successfully
program_hw_cfgmem: Time (s): cpu = 00:00:03 ; elapsed = 00:01:32 . Memory (MB): peak = 10391.516 ; gain = 0.000 ; free physical = 21232 ; free virtual = 29491
endgroup
```
However, after loading AS02MC04_dma_stream_crc64 over JTAG `quad_spi_flasher` still found a bitstream in flash:
```
Displaying information for SPI flash using AS02MC04_dma_stream_crc64 design in PCI device 0000:2d:00.0 IOMMU group 25
Initial device identification incorrect - ignoring due to Quad SPI core not outputting initial clock cycles
FIFO depth=256
Flash device : Micron N25Q256A
Manufacturer ID=0x20  Memory Interface Type=0xbb  Density=0x19
Flash Size Bytes=33554432  Page Size Bytes=256  Num Address Bytes=4
Successfully parsed bitstream of length 32212444 bytes with 466 configuration packets
Read 32243712 bytes from SPI flash starting at address 0
Sync word at byte index 0x1001050
  Type 1 packet opcode NOP
  Type 1 packet opcode write register BSPI words 0000066C
  Type 1 packet opcode write register CMD command BSPI_READ
  Type 1 packet opcode NOP (2 consecutive)
  Type 1 packet opcode write register TIMER words 00000000
  Type 1 packet opcode write register WBSTAR words 00000000
  Type 1 packet opcode write register CMD command NULL
  Type 1 packet opcode NOP
  Type 1 packet opcode write register CMD command RCRC
  Type 1 packet opcode NOP (2 consecutive)
  Type 1 packet opcode write register FAR words 00000000
  Type 1 packet opcode write register RBCRC_SW words 00000000
  Type 1 packet opcode write register COR0 words 383A3FE5
  Type 1 packet opcode write register COR1 words 00400000
  Type 1 packet opcode write register IDCODE KU3P
  Type 1 packet opcode write register CMD command FALL_EDGE
  Type 1 packet opcode write register CMD command SWITCH
  Type 1 packet opcode NOP
  Type 1 packet opcode write register MASK words 00000001
  Type 1 packet opcode write register CTL0 words 00000101
  Type 1 packet opcode write register MASK words 00000000
  Type 1 packet opcode write register CTL1 words 00000000
  Type 1 packet opcode NOP (8 consecutive)
  Configuration data writes consisting of:
    1 NOPs
    1 FAR writes
    1 WCFG commands
    1 FDRI writes with a total of 0 words
    1 Type 2 packets with a total of 3857268 words
  Type 1 packet opcode write register CRC words 6E1E7B1E
  Type 1 packet opcode NOP (2 consecutive)
  Type 1 packet opcode write register CMD command GRESTORE
  Type 1 packet opcode NOP (2 consecutive)
  Type 1 packet opcode write register CMD command DGHIGH_LFRM
  Type 1 packet opcode NOP (20 consecutive)
  Type 1 packet opcode write register CMD command START
  Type 1 packet opcode NOP
  Type 1 packet opcode write register FAR words 07FC0000
  Type 1 packet opcode write register MASK words 00000101
  Type 1 packet opcode write register CTL0 words 00000101
  Type 1 packet opcode write register CRC words DD03E29D
  Type 1 packet opcode NOP (2 consecutive)
  Type 1 packet opcode write register CMD command DESYNC
  Type 1 packet opcode NOP (393 consecutive)
```
The Sync word being found at byte offset `0x1001050`, which is just over half way through the QSPI address range suggests a fallback image.

`boot_hw_device.sh` indicated the FPGA could still boot from the configuration memory:
```
source /home/mr_halfword/fpga_sio/multiple_boards/boot_hw_device.tcl -notrace
Booting xcku3p_0
INFO: [Labtoolstcl 44-664] Will wait up to 180 seconds for booting to complete.
INFO: [Labtools 27-32] Done pin status: HIGH
boot_hw_device: Time (s): cpu = 00:00:00.05 ; elapsed = 00:01:08 . Memory (MB): peak = 2012.297 ; gain = 0.000 ; free physical = 20120 ; free virtual = 28795
```
Initially was confused while when selected only an Erase operation, Vivado reported an error if no configuration file was specified, but subsequently realised that the Address Range of _Configuration File Only_ is what required the configuration file to be specified before the partial erase could be performed.

While found a bitstream with a Sync word offset at both offset 0x50 and 0x1001050 they both had:
- WBSTAR (Warm Boot Start Address Register) is zero
- No IPROG cmmand

So, can't see any automatic fallback if one bitstream fails to load.

## 4.4.2. Perform a full erase

Performed another erase in the Hardware Manager, but this time the Address Range was set to _Erase Configuration Memory Device_.

The Vivado Tcl Console reported success, with a longer elapsed time than the partial erase:
```
program_hw_cfgmem -hw_cfgmem [ get_property PROGRAM.HW_CFGMEM [lindex [get_hw_devices xcku3p_0] 0]]
Mfg ID : 20   Memory Type : bb   Memory Capacity : 19   Device ID 1 : 0   Device ID 2 : 0
Performing Erase Operation...
Erase Operation successful.
Performing Blank Check Operation...
Blank Check Operation successful. The part is blank.
INFO: [Labtoolstcl 44-377] Flash programming completed successfully
program_hw_cfgmem: Time (s): cpu = 00:00:18 ; elapsed = 00:08:35 . Memory (MB): peak = 10391.516 ; gain = 0.000 ; free physical = 20470 ; free virtual = 29164
```
After loading AS02MC04_dma_stream_crc64 over JTAG `quad_spi_flasher` can no longer find a bitstream:
```
isplaying information for SPI flash using AS02MC04_dma_stream_crc64 design in PCI device 0000:2d:00.0 IOMMU group 25
Initial device identification incorrect - ignoring due to Quad SPI core not outputting initial clock cycles
FIFO depth=256
Flash device : Micron N25Q256A
Manufacturer ID=0x20  Memory Interface Type=0xbb  Density=0x19
Flash Size Bytes=33554432  Page Size Bytes=256  Num Address Bytes=4
Error parsing bitstream: No Sync word found
Read 33554432 bytes from SPI flash starting at address 0
```
And `boot_hw_device.sh` now reports a failure to boot from configuration memory:
```
source /home/mr_halfword/fpga_sio/multiple_boards/boot_hw_device.tcl -notrace
Booting xcku3p_0
INFO: [Labtoolstcl 44-664] Will wait up to 180 seconds for booting to complete.
ERROR: [Labtools 27-2254] Booting from configuration memory device unsuccessful.
boot_hw_device: Time (s): cpu = 00:00:00.12 ; elapsed = 00:03:01 . Memory (MB): peak = 2012.297 ; gain = 0.000 ; free physical = 19919 ; free virtual = 28718
ERROR: [Common 17-39] 'boot_hw_device' failed due to earlier errors
```

## 4.5.3. With erased configuration flash, at power up two x4 slots

Powered up with the configuration flash erased. There were two x4 root ports for slot 5:
```
$ dump_info/dump_pci_info_pciutils 8086:2030 8086:2031
domain=0000 bus=2c dev=00 func=00 rev=04
  vendor_id=8086 (Intel Corporation) device_id=2030 (Sky Lake-E PCI Express Root Port A)
  iommu_group=74
  driver=pcieport
  physical_slot=5
  control: I/O+ Mem+ BusMaster+ ParErr- SERR- DisINTx+
  status: INTx- <ParErr- >TAbort- <TAbort- <MAbort- >SERR- DetParErr-
  Capabilities: [40] Bridge subsystem vendor/device ID
  Capabilities: [60] Message Signaled Interrupts
  Capabilities: [90] PCI Express v2 Root Port, MSI 0
    Link capabilities: Max speed 8 GT/s Max width x4
    Negotiated link status: Current speed 2.5 GT/s Width x0
    Link capabilities2: Supported link speeds 2.5 GT/s 5.0 GT/s 8.0 GT/s
    DevCap: MaxPayload 256 bytes PhantFunc 0 Latency L0s Maximum of 64 ns L1 Maximum of 1 μs
            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
    DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
    DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
    LnkCap: Port # 9 ASPM not supported
            L0s Exit Latency 256 ns to less than 512 ns
            L1 Exit Latency 8 μs to less than 16 μs
            ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
    LnkCtl: ASPM Disabled RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- ABWMgmt-
    LnkSta: TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
    SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise-
            Slot #5 PowerLimit 0.000W Interlock- NoCompl-
  Capabilities: [e0] Power Management

<<snip>>

domain=0000 bus=2c dev=01 func=00 rev=04
  vendor_id=8086 (Intel Corporation) device_id=2031 (Sky Lake-E PCI Express Root Port B)
  iommu_group=75
  driver=pcieport
  physical_slot=5-1
  control: I/O+ Mem+ BusMaster+ ParErr- SERR- DisINTx+
  status: INTx- <ParErr- >TAbort- <TAbort- <MAbort- >SERR- DetParErr-
  Capabilities: [40] Bridge subsystem vendor/device ID
  Capabilities: [60] Message Signaled Interrupts
  Capabilities: [90] PCI Express v2 Root Port, MSI 0
    Link capabilities: Max speed 8 GT/s Max width x4
    Negotiated link status: Current speed 2.5 GT/s Width x0
    Link capabilities2: Supported link speeds 2.5 GT/s 5.0 GT/s 8.0 GT/s
    DevCap: MaxPayload 256 bytes PhantFunc 0 Latency L0s Maximum of 64 ns L1 Maximum of 1 μs
            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
    DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop-
    DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
    LnkCap: Port # 10 ASPM not supported
            L0s Exit Latency 256 ns to less than 512 ns
            L1 Exit Latency 8 μs to less than 16 μs
            ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
    LnkCtl: ASPM Disabled RCB 64 bytes Disabled+ CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- ABWMgmt-
    LnkSta: TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
    SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #5 PowerLimit 0.000W Interlock- NoCompl-
  Capabilities: [e0] Power Management
```
In the BIOS changed the slot 5 bifurcation from Auto to x8. On a power cycle that still resulted in slot 5 having two x4 slots.

### 4.5.4. gen1_x8_example_lane_order

This fails to enumerate, either after loading over JTAG or rebooting.

### 4.5.5. gen1_x8_reversed_lane_order

This enumerated after loading over JTAG, as x4 width on physical slot 5-2.

If reboot with the design loaded, the link goes down and doesn't come up at reboot.
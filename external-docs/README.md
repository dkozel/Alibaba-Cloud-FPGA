Bringup Notes, mostly around PCIe bus width and enumeration
https://gist.github.com/Chester-Gillon/765d6286b1c34c7dc26a7b4c4dd0c48c

Board Constraints file:
https://github.com/TiferKing/as02mc04_hack

"Corundum is an open-source, high-performance FPGA-based NIC and platform for in-network compute. Features include a high performance datapath, 10G/25G/100G Ethernet, PCI express gen 3, a custom, high performance, tightly-integrated PCIe DMA engine, many (1000+) transmit, receive, completion, and event queues, scatter/gather DMA, MSI interrupts, multiple interfaces, multiple ports per interface, per-port transmit scheduling including high precision TDMA, flow hashing, RSS, checksum offloading, and native IEEE 1588 PTP timestamping."

The next generation of Corundum is being ported into System Verilog and using the Alibaba AS02MC04 board as a reference platform.
https://github.com/fpganinja/taxi/tree/master/src/cndm/board/AS02MC04/fpga

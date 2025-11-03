# A MT25QU256 with a 1.8V support is used as the configuration QuadSPI flash
#
# The STARTUP primitive has been enabled in the QAUD SPI block, and "Startup internal to IP" selected.
# As a result, no pins need to be defined here.
#
# Taken from https://zhuanlan.zhihu.com/p/25813982411
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 31.9 [current_design]

# Since the MT25QU256 is  256 Mb
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]

# For tracking the version of the bitstream
set_property BITSTREAM.CONFIG.USR_ACCESS TIMESTAMP [current_design]


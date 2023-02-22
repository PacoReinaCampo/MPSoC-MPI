@echo off
call ../../../../../../settings64_ghdl.bat

ghdl -a --std=08 ../../../../../../rtl/vhdl/peripheral/ahb3/peripheral_mpi_ahb3.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/core/peripheral_mpi.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/core/peripheral_packet_buffer.vhd
ghdl -a --std=08 ../../../../../../bench/vhdl/tests/peripheral/ahb3/peripheral_mpi_testbench.vhd
ghdl -m --std=08 peripheral_mpi_testbench
ghdl -r --std=08 peripheral_mpi_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > peripheral_mpi_testbench.tree
pause

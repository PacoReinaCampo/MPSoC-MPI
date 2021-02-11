@echo off
call ../../../../../../settings64_ghdl.bat

ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/wb/mpsoc_mpi_wb.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/core/mpsoc_mpi.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/core/mpsoc_packet_buffer.vhd
ghdl -a --std=08 ../../../../../../bench/vhdl/tests/core/wb/mpsoc_mpi_testbench.vhd
ghdl -m --std=08 mpsoc_mpi_testbench
ghdl -r --std=08 mpsoc_mpi_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > mpsoc_mpi_testbench.tree
pause

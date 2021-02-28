all: build simulate

build:
	ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/pkg/vhdl_pkg.vhd
	ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/wb/peripheral_mpi_wb.vhd
	ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/core/peripheral_mpi.vhd
	ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/core/peripheral_packet_buffer.vhd
	ghdl -a --std=08 ../../../../../../bench/vhdl/tests/core/wb/peripheral_mpi_testbench.vhd

simulate:
	ghdl -m --std=08 peripheral_mpi_testbench
	ghdl -r --std=08 peripheral_mpi_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > peripheral_mpi_testbench.tree

clean:
	rm -f *.cf *.tree

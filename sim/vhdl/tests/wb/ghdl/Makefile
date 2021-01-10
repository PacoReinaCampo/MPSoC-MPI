all: build simulate

build:
	ghdl -a --std=08 ../../../../../rtl/vhdl/wb/wb/mpsoc_mpi_wb.vhd
	ghdl -a --std=08 ../../../../../rtl/vhdl/wb/core/mpsoc_mpi.vhd
	ghdl -a --std=08 ../../../../../rtl/vhdl/wb/core/mpsoc_packet_buffer.vhd
	ghdl -a --std=08 ../../../../../bench/vhdl/tests/wb/mpsoc_mpi_testbench.vhd

simulate:
	ghdl -m --std=08 mpsoc_mpi_testbench
	ghdl -r --std=08 mpsoc_mpi_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > mpsoc_mpi_testbench.tree

clean:
	rm -f *.cf *.tree

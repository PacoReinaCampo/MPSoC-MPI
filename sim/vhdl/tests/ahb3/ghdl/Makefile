all: build simulate

build:
	ghdl -a --std=08 ../../../../../rtl/vhdl/ahb3/ahb3/mpsoc_mpi_ahb3.vhd
	ghdl -a --std=08 ../../../../../rtl/vhdl/ahb3/core/mpsoc_mpi.vhd
	ghdl -a --std=08 ../../../../../rtl/vhdl/ahb3/core/mpsoc_packet_buffer.vhd
	ghdl -a --std=08 ../../../../../bench/vhdl/tests/ahb3/mpsoc_mpi_testbench.vhd

simulate:
	ghdl -m --std=08 mpsoc_mpi_testbench
	ghdl -r --std=08 mpsoc_mpi_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > mpsoc_mpi_testbench.tree

clean:
	rm -f *.cf *.tree

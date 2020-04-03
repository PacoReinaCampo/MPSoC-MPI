all: build

build:
	@if [ ! -e work ]; then vlib work; fi
	@vlog -sv +incdir+../../../../rtl/verilog/pkg -f mpi.vc
	vsim -c -do run.do work.mpsoc_mpi_testbench

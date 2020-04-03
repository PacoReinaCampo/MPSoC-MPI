all: build

build:
	@if [ ! -e work ]; then vlib work; fi
	@vlog -sv +incdir+../../../../rtl/verilog/pkg -f mpi_verilog.vc
	@vcom -2008 -f mpi_vhdl.vc
	vsim -c -do run.do work.mpsoc_mpi_testbench

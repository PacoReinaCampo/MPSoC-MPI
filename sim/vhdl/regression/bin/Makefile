all: build

build:
	@if [ ! -e work ]; then vlib work; fi
	@vcom -2008 -f mpi.vc
	vsim -c -do run.do work.mpsoc_mpi_testbench

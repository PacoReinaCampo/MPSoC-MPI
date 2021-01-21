all: build simulate

build:
	iverilog -g2012 -o system.vvp -c system.vc -s mpsoc_mpi_testbench -I ../../../../../../rtl/verilog/bb/pkg

simulate:
	vvp system.vvp

clean:
	rm -rf system.vvp

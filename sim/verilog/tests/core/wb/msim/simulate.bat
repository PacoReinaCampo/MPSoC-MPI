del transcript
rmdir /s /q work
vlib work
vlog -sv +incdir+../../../../../rtl/verilog/wb/pkg -f system.vc
vsim -c -do run.do wb_mpi_tb
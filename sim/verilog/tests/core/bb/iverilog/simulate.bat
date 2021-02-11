@echo off
call ../../../../../../settings64_iverilog.bat

iverilog -g2012 -o system.vvp -c system.vc -s mpsoc_mpi_testbench -I ../../../../../../rtl/verilog/bb/pkg
vvp system.vvp
pause

@echo off
call ../../../../../../settings64_iverilog.bat

iverilog -g2012 -o system.vvp -c system.vc -s wb_mpi_tb
vvp system.vvp
pause

@echo off
call ../../../../../../settings64_iverilog.bat

vlib work
vlog -sv -f system.vc
vsim -c -do run.do work.peripheral_mpi_testbench
pause

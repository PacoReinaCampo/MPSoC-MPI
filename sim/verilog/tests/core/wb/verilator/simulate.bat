@echo off
call ../../../../../../settings64_verilator.bat

verilator -Wno-lint -Wno-UNOPTFLAT -Wno-COMBDLY +incdir+../../../../../../rtl/verilog/wb/pkg --cc -f system.vc --top-module mpsoc_mpi_testbench
pause

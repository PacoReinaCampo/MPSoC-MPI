////////////////////////////////////////////////////////////////////////////////
//                                            __ _      _     _               //
//                                           / _(_)    | |   | |              //
//                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              //
//               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              //
//              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              //
//               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              //
//                  | |                                                       //
//                  |_|                                                       //
//                                                                            //
//                                                                            //
//              MPSoC-RISCV CPU                                               //
//              Message Passing Interface                                     //
//              AMBA3 AHB-Lite Bus Interface                                  //
//              WishBone Bus Interface                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/* Copyright (c) 2018-2019 by the author(s)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * =============================================================================
 * Author(s):
 *   Paco Reina Campo <pacoreinacampo@queenfield.tech>
 */

module mpsoc_mpi_testbench;

  //////////////////////////////////////////////////////////////////
  //
  // Constants
  //
  parameter NOC_FLIT_WIDTH = 32;
  parameter SIZE           = 16;
  parameter N              = 1;

  //////////////////////////////////////////////////////////////////
  //
  // Variables
  //
  logic clk;
  logic rst;

  // WB
  logic [N*NOC_FLIT_WIDTH-1:0] wb_noc_out_flit;
  logic [N               -1:0] wb_noc_out_last;
  logic [N               -1:0] wb_noc_out_valid;
  logic [N               -1:0] wb_noc_out_ready;

  logic [N*NOC_FLIT_WIDTH-1:0] wb_noc_in_flit;
  logic [N               -1:0] wb_noc_in_last;
  logic [N               -1:0] wb_noc_in_valid;
  logic [N               -1:0] wb_noc_in_ready;

  logic [                31:0] wb_mpi_adr_i;
  logic                        wb_mpi_we_i;
  logic                        wb_mpi_cyc_i;
  logic                        wb_mpi_stb_i;
  logic [                31:0] wb_mpi_dat_i;
  logic [                31:0] wb_mpi_dat_o;
  logic                        wb_mpi_ack_o;
  logic                        wb_mpi_err_o;

  logic                        wb_irq;

  //////////////////////////////////////////////////////////////////
  //
  // Module Body
  //

  //DUT WB
  mpi_wb #(
    .NOC_FLIT_WIDTH ( NOC_FLIT_WIDTH ),
    .SIZE           ( SIZE           ),
    .N              ( N              )
  )
  mpi (
    .clk ( clk ),
    .rst ( rst ),

    // NoC interface
    .noc_out_flit  ( wb_noc_out_flit  ),
    .noc_out_last  ( wb_noc_out_last  ),
    .noc_out_valid ( wb_noc_out_valid ),
    .noc_out_ready ( wb_noc_out_ready ),

    .noc_in_flit  ( wb_noc_in_flit  ),
    .noc_in_last  ( wb_noc_in_last  ),
    .noc_in_valid ( wb_noc_in_valid ),
    .noc_in_ready ( wb_noc_in_ready ),

    .wb_adr_i ( wb_mpi_adr_i ),
    .wb_we_i  ( wb_mpi_we_i  ),
    .wb_cyc_i ( wb_mpi_cyc_i ),
    .wb_stb_i ( wb_mpi_stb_i ),
    .wb_dat_i ( wb_mpi_dat_i ),
    .wb_dat_o ( wb_mpi_dat_o ),
    .wb_ack_o ( wb_mpi_ack_o ),
    .wb_err_o ( wb_mpi_err_o ),

    .irq ( wb_irq )
  );
endmodule

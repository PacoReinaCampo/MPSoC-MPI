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
//              Blackbone Bus Interface                                       //
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

  // BB
  logic [N*NOC_FLIT_WIDTH-1:0] bb_noc_out_flit;
  logic [N               -1:0] bb_noc_out_last;
  logic [N               -1:0] bb_noc_out_valid;
  logic [N               -1:0] bb_noc_out_ready;

  logic [N*NOC_FLIT_WIDTH-1:0] bb_noc_in_flit;
  logic [N               -1:0] bb_noc_in_last;
  logic [N               -1:0] bb_noc_in_valid;
  logic [N               -1:0] bb_noc_in_ready;


  logic [                31:0] bb_addr_i;
  logic [                31:0] bb_din_i;
  logic                        bb_en_i;
  logic                        bb_we_i;

  logic [                31:0] bb_dout_o;

  logic                        bb_irq;

  //////////////////////////////////////////////////////////////////
  //
  // Module Body
  //

  //DUT BB
  mpi_bb #(
    .NOC_FLIT_WIDTH (NOC_FLIT_WIDTH),
    .SIZE           (SIZE),
    .N              (N)
  )
  mpi (
    .clk ( clk ),
    .rst ( rst ),

    // NoC interface
    .noc_out_flit  ( bb_noc_out_flit  ),
    .noc_out_last  ( bb_noc_out_last  ),
    .noc_out_valid ( bb_noc_out_valid ),
    .noc_out_ready ( bb_noc_out_ready ),

    .noc_in_flit  ( bb_noc_in_flit  ),
    .noc_in_last  ( bb_noc_in_last  ),
    .noc_in_valid ( bb_noc_in_valid ),
    .noc_in_ready ( bb_noc_in_ready ),

    .bb_addr_i ( bb_addr_i ),
    .bb_din_i  ( bb_din_i  ),
    .bb_en_i   ( bb_en_i   ),
    .bb_we_i   ( bb_we_i   ),

    .bb_dout_o ( bb_dout_o ),

    .irq ( bb_irq )
  );
endmodule

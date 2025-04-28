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
//              Peripheral-MPI for MPSoC                                      //
//              Message Passing Interface for MPSoC                           //
//              AMBA3 AHB-Lite Bus Interface                                  //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2018-2019 by the author(s)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
////////////////////////////////////////////////////////////////////////////////
// Author(s):
//   Paco Reina Campo <pacoreinacampo@queenfield.tech>

module peripheral_mpi_testbench;

  //////////////////////////////////////////////////////////////////////////////
  // Constants
  //////////////////////////////////////////////////////////////////////////////

  parameter NOC_FLIT_WIDTH = 32;
  parameter SIZE = 16;
  parameter N = 1;

  //////////////////////////////////////////////////////////////////////////////
  // Variables
  //////////////////////////////////////////////////////////////////////////////

  logic                        clk;
  logic                        rst;

  // AHB
  logic [N*NOC_FLIT_WIDTH-1:0] ahb_noc_out_flit;
  logic [N               -1:0] ahb_noc_out_last;
  logic [N               -1:0] ahb_noc_out_valid;
  logic [N               -1:0] ahb_noc_out_ready;

  logic [N*NOC_FLIT_WIDTH-1:0] ahb_noc_in_flit;
  logic [N               -1:0] ahb_noc_in_last;
  logic [N               -1:0] ahb_noc_in_valid;
  logic [N               -1:0] ahb_noc_in_ready;

  logic                        tl_hsel_i;
  logic [                31:0] tl_haddr_i;
  logic [                31:0] tl_hwdata_i;
  logic                        tl_hwrite_i;
  logic [                 2:0] tl_hsize_i;
  logic [                 2:0] tl_hburst_i;
  logic [                 3:0] tl_hprot_i;
  logic [                 1:0] tl_htrans_i;
  logic                        tl_hmastlock_i;

  logic [                31:0] tl_hrdata_o;
  logic                        tl_hready_o;
  logic                        tl_hresp_o;

  logic                        tl_irq;

  //////////////////////////////////////////////////////////////////////////////
  // Body
  //////////////////////////////////////////////////////////////////////////////

  // DUT AHB4
  peripheral_mpi_tl #(
    .NOC_FLIT_WIDTH(NOC_FLIT_WIDTH),
    .SIZE          (SIZE),
    .N             (N)
  ) mpi_tl (
    .clk(clk),
    .rst(rst),

    // NoC interface
    .noc_out_flit (ahb_noc_out_flit),
    .noc_out_last (ahb_noc_out_last),
    .noc_out_valid(ahb_noc_out_valid),
    .noc_out_ready(ahb_noc_out_ready),

    .noc_in_flit (ahb_noc_in_flit),
    .noc_in_last (ahb_noc_in_last),
    .noc_in_valid(ahb_noc_in_valid),
    .noc_in_ready(ahb_noc_in_ready),

    .tl_hsel_i     (tl_hsel_i),
    .tl_haddr_i    (tl_haddr_i),
    .tl_hwdata_i   (tl_hwdata_i),
    .tl_hwrite_i   (tl_hwrite_i),
    .tl_hsize_i    (tl_hsize_i),
    .tl_hburst_i   (tl_hburst_i),
    .tl_hprot_i    (tl_hprot_i),
    .tl_htrans_i   (tl_htrans_i),
    .tl_hmastlock_i(tl_hmastlock_i),

    .tl_hrdata_o(tl_hrdata_o),
    .tl_hready_o(tl_hready_o),
    .tl_hresp_o (tl_hresp_o),

    .irq(tl_irq)
  );
endmodule

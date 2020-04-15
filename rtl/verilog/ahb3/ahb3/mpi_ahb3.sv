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
 *   Francisco Javier Reina Campo <frareicam@gmail.com>
 */

module mpi_ahb3 #(
  parameter NOC_FLIT_WIDTH = 32,
  parameter SIZE           = 16,
  parameter N              = 1
)
  (
    input clk,
    input rst,

    output [N*NOC_FLIT_WIDTH-1:0] noc_out_flit,
    output [N               -1:0] noc_out_last,
    output [N               -1:0] noc_out_valid,
    input  [N               -1:0] noc_out_ready,

    input  [N*NOC_FLIT_WIDTH-1:0] noc_in_flit,
    input  [N               -1:0] noc_in_last,
    input  [N               -1:0] noc_in_valid,
    output [N               -1:0] noc_in_ready,

    input  [                31:0] HADDR,
    input                         HWRITE,
    input                         HMASTLOCK,
    input                         HSEL,
    input  [                31:0] HRDATA,
    output [                31:0] HWDATA,
    output                        HREADY,

    output                        irq
  );

  //////////////////////////////////////////////////////////////////
  //
  // Variables
  //

  // Bus side (generic)
  wire [31:0] bus_addr;
  wire        bus_we;
  wire        bus_en;
  wire [31:0] bus_data_in;
  wire [31:0] bus_data_out;
  wire        bus_ack;
  wire        bus_err;

  //////////////////////////////////////////////////////////////////
  //
  // Module body
  //

  assign bus_addr    = HADDR;
  assign bus_we      = HWRITE;
  assign bus_en      = HMASTLOCK & HSEL;
  assign bus_data_in = HRDATA;
  assign HWDATA      = bus_data_out;
  assign HREADY      = bus_ack;

  mpi_buffer #(
    .NOC_FLIT_WIDTH (NOC_FLIT_WIDTH),
    .SIZE           (SIZE),
    .N              (N)
  )
  u_buffer (
    .clk           (clk),
    .rst           (rst),

    .noc_out_flit  (noc_out_flit),
    .noc_out_last  (noc_out_last),
    .noc_out_valid (noc_out_valid),
    .noc_out_ready (noc_out_ready),

    .noc_in_flit   (noc_in_flit),
    .noc_in_last   (noc_in_last),
    .noc_in_valid  (noc_in_valid),
    .noc_in_ready  (noc_in_ready),

    // Bus side (generic)
    .bus_addr     (bus_addr),
    .bus_we       (bus_we),
    .bus_en       (bus_en),
    .bus_data_in  (bus_data_in),
    .bus_data_out (bus_data_out),
    .bus_ack      (bus_ack),
    .bus_err      (bus_err),

    .irq (irq)
  );
endmodule

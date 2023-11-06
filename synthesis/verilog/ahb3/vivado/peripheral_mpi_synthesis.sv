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
//              Universal Asynchronous Receiver-Transmitter                   //
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
 *   Paco Reina Campo <pacoreinacampo@queenfield.tech>
 */

module peripheral_mpi_synthesis #(
  parameter HADDR_SIZE     = 8,
  parameter HDATA_SIZE     = 32,
  parameter APB_ADDR_WIDTH = 8,
  parameter APB_DATA_WIDTH = 32,
  parameter SYNC_DEPTH     = 3
) (
  // Common signals
  input HRESETn,
  input HCLK,

  // UART AHB3
  input                         mpi_HSEL,
  input      [HADDR_SIZE  -1:0] mpi_HADDR,
  input      [HDATA_SIZE  -1:0] mpi_HWDATA,
  output reg [HDATA_SIZE  -1:0] mpi_HRDATA,
  input                         mpi_HWRITE,
  input      [             2:0] mpi_HSIZE,
  input      [             2:0] mpi_HBURST,
  input      [             3:0] mpi_HPROT,
  input      [             1:0] mpi_HTRANS,
  input                         mpi_HMASTLOCK,
  output reg                    mpi_HREADYOUT,
  input                         mpi_HREADY,
  output reg                    mpi_HRESP
);

  //////////////////////////////////////////////////////////////////
  // Variables
  //////////////////////////////////////////////////////////////////////////////

  // Common signals
  logic [APB_ADDR_WIDTH -1:0] mpi_PADDR;
  logic [APB_DATA_WIDTH -1:0] mpi_PWDATA;
  logic                       mpi_PWRITE;
  logic                       mpi_PSEL;
  logic                       mpi_PENABLE;
  logic [APB_DATA_WIDTH -1:0] mpi_PRDATA;
  logic                       mpi_PREADY;
  logic                       mpi_PSLVERR;

  logic                       mpi_rx_i;  // Receiver input
  logic                       mpi_tx_o;  // Transmitter output

  logic                       mpi_event_o;

  //////////////////////////////////////////////////////////////////
  // Module Body
  //////////////////////////////////////////////////////////////////////////////

  // DUT AHB3
  peripheral_bridge_apb2ahb #(
    .HADDR_SIZE(HADDR_SIZE),
    .HDATA_SIZE(HDATA_SIZE),
    .PADDR_SIZE(APB_ADDR_WIDTH),
    .PDATA_SIZE(APB_DATA_WIDTH),
    .SYNC_DEPTH(SYNC_DEPTH)
  ) bridge_apb2ahb (
    // AHB Slave Interface
    .HRESETn(HRESETn),
    .HCLK   (HCLK),

    .HSEL     (mpi_HSEL),
    .HADDR    (mpi_HADDR),
    .HWDATA   (mpi_HWDATA),
    .HRDATA   (mpi_HRDATA),
    .HWRITE   (mpi_HWRITE),
    .HSIZE    (mpi_HSIZE),
    .HBURST   (mpi_HBURST),
    .HPROT    (mpi_HPROT),
    .HTRANS   (mpi_HTRANS),
    .HMASTLOCK(mpi_HMASTLOCK),
    .HREADYOUT(mpi_HREADYOUT),
    .HREADY   (mpi_HREADY),
    .HRESP    (mpi_HRESP),

    // APB Master Interface
    .PRESETn(HRESETn),
    .PCLK   (HCLK),

    .PSEL   (mpi_PSEL),
    .PENABLE(mpi_PENABLE),
    .PPROT  (),
    .PWRITE (mpi_PWRITE),
    .PSTRB  (),
    .PADDR  (mpi_PADDR),
    .PWDATA (mpi_PWDATA),
    .PRDATA (mpi_PRDATA),
    .PREADY (mpi_PREADY),
    .PSLVERR(mpi_PSLVERR)
  );

  peripheral_apb4_mpi #(
    .APB_ADDR_WIDTH(APB_ADDR_WIDTH),
    .APB_DATA_WIDTH(APB_DATA_WIDTH)
  ) apb4_mpi (
    .RSTN(HRESETn),
    .CLK (HCLK),

    .PADDR  (mpi_PADDR),
    .PWDATA (mpi_PWDATA),
    .PWRITE (mpi_PWRITE),
    .PSEL   (mpi_PSEL),
    .PENABLE(mpi_PENABLE),
    .PRDATA (mpi_PRDATA),
    .PREADY (mpi_PREADY),
    .PSLVERR(mpi_PSLVERR),

    .rx_i(mpi_rx_i),
    .tx_o(mpi_tx_o),

    .event_o(mpi_event_o)
  );
endmodule

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
//              BackBone Bus Interface                                       //
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

module peripheral_mpi_synthesis (
  input mclk,    // Main system clock
  input puc_rst, // Main system reset

  input smclk_en,  // SMCLK enable (from CPU)

  input  [13:0] per_addr,  // Peripheral address
  output [15:0] per_dout,  // Peripheral data output
  input  [15:0] per_din,   // Peripheral data input
  input         per_en,    // Peripheral enable (high active)
  input  [ 1:0] per_we,    // Peripheral write enable (high active)

  output irq_mpi_rx,  // UART receive interrupt
  output irq_mpi_tx,  // UART transmit interrupt
  input  mpi_rxd,     // UART Data Receive (RXD)
  output mpi_txd      // UART Data Transmit (TXD)
);

  //////////////////////////////////////////////////////////////////////////////
  // Body
  //////////////////////////////////////////////////////////////////////////////

  // DUT BB
  bb_mpi mpi (
    .mclk   (mclk),    // Main system clock
    .puc_rst(puc_rst), // Main system reset

    .smclk_en(smclk_en),  // SMCLK enable (from CPU)

    .per_addr(per_addr),  // Peripheral address
    .per_dout(per_dout),  // Peripheral data output
    .per_din (per_din),   // Peripheral data input
    .per_en  (per_en),    // Peripheral enable (high active)
    .per_we  (per_we),    // Peripheral write enable (high active)

    .irq_mpi_rx(irq_mpi_rx),  // UART receive interrupt
    .irq_mpi_tx(irq_mpi_tx),  // UART transmit interrupt
    .mpi_rxd   (mpi_rxd),     // UART Data Receive (RXD)
    .mpi_txd   (mpi_txd)      // UART Data Transmit (TXD)
  );
endmodule

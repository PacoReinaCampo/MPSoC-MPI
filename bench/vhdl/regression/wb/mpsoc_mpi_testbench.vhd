-- Converted from bench/verilog/regression/mpsoc_mpi_testbench.sv
-- by verilog2vhdl - QueenField

--//////////////////////////////////////////////////////////////////////////////
--                                            __ _      _     _               //
--                                           / _(_)    | |   | |              //
--                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              //
--               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              //
--              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              //
--               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              //
--                  | |                                                       //
--                  |_|                                                       //
--                                                                            //
--                                                                            //
--              MPSoC-RISCV CPU                                               //
--              Message Passing Interface                                     //
--              Wishbone Bus Interface                                        //
--                                                                            //
--//////////////////////////////////////////////////////////////////////////////

-- Copyright (c) 2018-2019 by the author(s)
-- *
-- * Permission is hereby granted, free of charge, to any person obtaining a copy
-- * of this software and associated documentation files (the "Software"), to deal
-- * in the Software without restriction, including without limitation the rights
-- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- * copies of the Software, and to permit persons to whom the Software is
-- * furnished to do so, subject to the following conditions:
-- *
-- * The above copyright notice and this permission notice shall be included in
-- * all copies or substantial portions of the Software.
-- *
-- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- * THE SOFTWARE.
-- *
-- * =============================================================================
-- * Author(s):
-- *   Paco Reina Campo <pacoreinacampo@queenfield.tech>
-- */

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity mpsoc_mpi_testbench is
end mpsoc_mpi_testbench;

architecture RTL of mpsoc_mpi_testbench is
  component mpsoc_mpi_wb
    generic (
      NoC_DATA_WIDTH : integer := 32;
      NoC_TYPE_WIDTH : integer := 2;
      FIFO_DEPTH     : integer := 16;
      NoC_FLIT_WIDTH : integer := 34;
      SIZE_WIDTH     : integer := 5
      );
    port (
      clk : in std_logic;
      rst : in std_logic;

      -- NoC interface
      noc_out_flit  : out std_logic_vector(NoC_FLIT_WIDTH-1 downto 0);
      noc_out_valid : out std_logic;
      noc_out_ready : in  std_logic;

      noc_in_flit  : in  std_logic_vector(NoC_FLIT_WIDTH-1 downto 0);
      noc_in_valid : in  std_logic;
      noc_in_ready : out std_logic;

      wb_addr_i : in  std_logic_vector(5 downto 0);
      wb_we_i   : in  std_logic;
      wb_cyc_i  : in  std_logic;
      wb_stb_i  : in  std_logic;
      wb_dat_i  : in  std_logic_vector(NoC_DATA_WIDTH-1 downto 0);
      wb_dat_o  : out std_logic_vector(NoC_DATA_WIDTH-1 downto 0);
      wb_ack_o  : out std_logic;

      irq : out std_logic
      );
  end component;

  --////////////////////////////////////////////////////////////////
  --
  -- Constants
  --
  constant NoC_DATA_WIDTH : integer := 32;
  constant NoC_TYPE_WIDTH : integer := 2;
  constant FIFO_DEPTH     : integer := 16;
  constant NoC_FLIT_WIDTH : integer := 34;
  constant SIZE_WIDTH     : integer := 5;

  --////////////////////////////////////////////////////////////////
  --
  -- Variables
  --
  signal clk : std_logic;
  signal rst : std_logic;

  -- WB
  signal wb_noc_out_flit  : std_logic_vector(NoC_FLIT_WIDTH-1 downto 0);
  signal wb_noc_out_valid : std_logic;
  signal wb_noc_out_ready : std_logic;

  signal wb_noc_in_flit  : std_logic_vector(NoC_FLIT_WIDTH-1 downto 0);
  signal wb_noc_in_valid : std_logic;
  signal wb_noc_in_ready : std_logic;

  signal wb_mpi_addr_i : std_logic_vector(5 downto 0);
  signal wb_mpi_we_i   : std_logic;
  signal wb_mpi_cyc_i  : std_logic;
  signal wb_mpi_stb_i  : std_logic;
  signal wb_mpi_dat_i  : std_logic_vector(NoC_DATA_WIDTH-1 downto 0);
  signal wb_mpi_dat_o  : std_logic_vector(NoC_DATA_WIDTH-1 downto 0);
  signal wb_mpi_ack_o  : std_logic;

  signal wb_irq : std_logic;

begin
  --////////////////////////////////////////////////////////////////
  --
  -- Module Body
  --

  --DUT WB
  mpi_wb : mpsoc_mpi_wb
    generic map (
      NoC_DATA_WIDTH => NoC_DATA_WIDTH,
      NoC_TYPE_WIDTH => NoC_TYPE_WIDTH,
      FIFO_DEPTH     => FIFO_DEPTH,
      NoC_FLIT_WIDTH => NoC_FLIT_WIDTH,
      SIZE_WIDTH     => SIZE_WIDTH
      )
    port map (
      clk => clk,
      rst => rst,

      -- NoC interface
      noc_out_flit  => wb_noc_out_flit,
      noc_out_valid => wb_noc_out_valid,
      noc_out_ready => wb_noc_out_ready,

      noc_in_flit  => wb_noc_in_flit,
      noc_in_valid => wb_noc_in_valid,
      noc_in_ready => wb_noc_in_ready,

      wb_addr_i => wb_mpi_addr_i,
      wb_we_i   => wb_mpi_we_i,
      wb_cyc_i  => wb_mpi_cyc_i,
      wb_stb_i  => wb_mpi_stb_i,
      wb_dat_i  => wb_mpi_dat_i,
      wb_dat_o  => wb_mpi_dat_o,
      wb_ack_o  => wb_mpi_ack_o,

      irq => wb_irq
      );
end RTL;

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
--              AMBA3 AHB-Lite Bus Interface                                  //
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
-- *   Francisco Javier Reina Campo <frareicam@gmail.com>
-- */

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity mpsoc_mpi_testbench is
end mpsoc_mpi_testbench;

architecture RTL of mpsoc_mpi_testbench is
  component mpsoc_mpi_ahb3
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

      HADDR     : in  std_logic_vector(5 downto 0);
      HWRITE    : in  std_logic;
      HMASTLOCK : in  std_logic;
      HSEL      : in  std_logic;
      HRDATA    : in  std_logic_vector(NoC_DATA_WIDTH-1 downto 0);
      HWDATA    : out std_logic_vector(NoC_DATA_WIDTH-1 downto 0);
      HREADY    : out std_logic;

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

  -- AHB
  signal ahb_noc_out_flit  : std_logic_vector(NoC_FLIT_WIDTH-1 downto 0);
  signal ahb_noc_out_valid : std_logic;
  signal ahb_noc_out_ready : std_logic;

  signal ahb_noc_in_flit  : std_logic_vector(NoC_FLIT_WIDTH-1 downto 0);
  signal ahb_noc_in_valid : std_logic;
  signal ahb_noc_in_ready : std_logic;

  signal HADDR     : std_logic_vector(5 downto 0);
  signal HWRITE    : std_logic;
  signal HMASTLOCK : std_logic;
  signal HSEL      : std_logic;
  signal HRDATA    : std_logic_vector(NoC_DATA_WIDTH-1 downto 0);
  signal HWDATA    : std_logic_vector(NoC_DATA_WIDTH-1 downto 0);
  signal HREADY    : std_logic;

  signal ahb_irq : std_logic;

begin
  --////////////////////////////////////////////////////////////////
  --
  -- Module Body
  --

  --DUT AHB3
  mpi_ahb : mpsoc_mpi_ahb3
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
      noc_out_flit  => ahb_noc_out_flit,
      noc_out_valid => ahb_noc_out_valid,
      noc_out_ready => ahb_noc_out_ready,

      noc_in_flit  => ahb_noc_in_flit,
      noc_in_valid => ahb_noc_in_valid,
      noc_in_ready => ahb_noc_in_ready,

      HADDR     => HADDR,
      HWRITE    => HWRITE,
      HMASTLOCK => HMASTLOCK,
      HSEL      => HSEL,
      HRDATA    => HRDATA,
      HWDATA    => HWDATA,
      HREADY    => HREADY,

      irq => ahb_irq
      );
end RTL;

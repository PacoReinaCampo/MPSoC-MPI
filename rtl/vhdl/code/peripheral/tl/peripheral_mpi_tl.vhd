--------------------------------------------------------------------------------
--                                            __ _      _     _               --
--                                           / _(_)    | |   | |              --
--                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              --
--               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              --
--              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              --
--               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              --
--                  | |                                                       --
--                  |_|                                                       --
--                                                                            --
--                                                                            --
--              Peripheral-MPI for MPSoC                                      --
--              Message Passing Interface for MPSoC                           --
--              AMBA4 AHB-Lite Bus Interface                                  --
--                                                                            --
--------------------------------------------------------------------------------

-- Copyright (c) 2018-2019 by the author(s)
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--
--------------------------------------------------------------------------------
-- Author(s):
--   Stefan Wallentowitz <stefan.wallentowitz@tum.de>
--   Paco Reina Campo <pacoreinacampo@queenfield.tech>

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity peripheral_mpi_tl is
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
end peripheral_mpi_tl;

architecture rtl of peripheral_mpi_tl is

  ------------------------------------------------------------------------------
  -- Components
  ------------------------------------------------------------------------------

  component peripheral_mpi
    generic (
      NoC_DATA_WIDTH : integer := 32;
      NoC_TYPE_WIDTH : integer := 2;
      FIFO_DEPTH     : integer := 16;
      NoC_FLIT_WIDTH : integer := 34;
      SIZE_WIDTH     : integer := 5;

      PACKET_CLASS_CONTROL : std_logic_vector(2 downto 0) := "111"
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

      -- Bus side (generic)
      bus_addr     : in  std_logic_vector(5 downto 0);
      bus_we       : in  std_logic;
      bus_en       : in  std_logic;
      bus_data_in  : in  std_logic_vector(NoC_DATA_WIDTH-1 downto 0);
      bus_data_out : out std_logic_vector(NoC_DATA_WIDTH-1 downto 0);
      bus_ack      : out std_logic;

      irq : out std_logic
      );
  end component;

  ------------------------------------------------------------------------------
  -- Variables
  ------------------------------------------------------------------------------

  -- Bus side (generic)
  signal bus_addr     : std_logic_vector(5 downto 0);
  signal bus_we       : std_logic;
  signal bus_en       : std_logic;
  signal bus_data_in  : std_logic_vector(NoC_DATA_WIDTH-1 downto 0);
  signal bus_data_out : std_logic_vector(NoC_DATA_WIDTH-1 downto 0);
  signal bus_ack      : std_logic;

begin
  ------------------------------------------------------------------------------
  -- Module Body
  ------------------------------------------------------------------------------

  bus_addr    <= HADDR;
  bus_we      <= HWRITE;
  bus_en      <= HMASTLOCK and HSEL;
  bus_data_in <= HRDATA;
  HWDATA      <= bus_data_out;
  HREADY      <= bus_ack;

  mpi : peripheral_mpi
    generic map (
      NoC_DATA_WIDTH => NoC_DATA_WIDTH,
      NoC_TYPE_WIDTH => NoC_TYPE_WIDTH,
      FIFO_DEPTH     => FIFO_DEPTH
      )
    port map (
      clk => clk,
      rst => rst,

      -- Outputs
      noc_out_flit  => noc_out_flit(NoC_FLIT_WIDTH-1 downto 0),
      noc_out_valid => noc_out_valid,
      noc_in_ready  => noc_in_ready,
      -- Inputs
      noc_out_ready => noc_out_ready,
      noc_in_flit   => noc_in_flit(NoC_FLIT_WIDTH-1 downto 0),
      noc_in_valid  => noc_in_valid,

      bus_data_out => bus_data_out(NoC_DATA_WIDTH-1 downto 0),
      bus_ack      => bus_ack,
      irq          => irq,

      bus_addr    => bus_addr(5 downto 0),
      bus_we      => bus_we,
      bus_en      => bus_en,
      bus_data_in => bus_data_in(NoC_DATA_WIDTH-1 downto 0)
      );
end rtl;

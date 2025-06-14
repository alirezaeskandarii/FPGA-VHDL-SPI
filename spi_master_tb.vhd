--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:06:14 06/05/2025
-- Design Name:   
-- Module Name:   D:/fpga lpcarm/Projects/first_spi/spi_master_tb.vhd
-- Project Name:  first_spi
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: spi_master
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY spi_master_tb IS
END spi_master_tb;
 
ARCHITECTURE behavior OF spi_master_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT spi_master
    PORT(
         MISO : IN  std_logic;
         MOSI : OUT  std_logic;
         SCK : OUT  std_logic;
         SS : OUT  std_logic;
         clk : IN  std_logic;
         din : IN  std_logic_vector(7 downto 0);
         dout : OUT  std_logic_vector(7 downto 0);
         busy : OUT  std_logic;
         valid : OUT  std_logic;
         en : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal MISO : std_logic := '0';
   signal clk : std_logic := '0';
   signal din : std_logic_vector(7 downto 0) := (others => '0');
   signal en : std_logic := '0';

 	--Outputs
   signal MOSI : std_logic;
   signal SCK : std_logic;
   signal SS : std_logic;
   signal dout : std_logic_vector(7 downto 0);
   signal busy : std_logic;
   signal valid : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	constant data_miso : std_logic_vector(7 downto 0):=x"A3";
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: spi_master PORT MAP (
          MISO => MISO,
          MOSI => MOSI,
          SCK => SCK,
          SS => SS,
          clk => clk,
          din => din,
          dout => dout,
          busy => busy,
          valid => valid,
          en => en
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		din<=x"56";
		en<='1';
      wait for 20 ns;		
		en<='0';
      --ait for clk_period*10;
		
		--wait until ss='0';
		for i in 0 to 7 loop
		  MISO<=data_miso(7-i);
		  wait until SCK='1';
		  wait until SCK='0';
		end loop;
      -- insert stimulus here 

      wait;
   end process;

END;

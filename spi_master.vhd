----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:54:53 05/30/2025 
-- Design Name: 
-- Module Name:    spi_master - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi_master is
    Port ( MISO 	: in   STD_LOGIC;
           MOSI 	: out  STD_LOGIC;
           SCK 	: out  STD_LOGIC;
           SS 		: out  STD_LOGIC;
           clk 	: in   STD_LOGIC;
           din 	: in   STD_LOGIC_VECTOR (7 downto 0);
           dout 	: out  STD_LOGIC_VECTOR (7 downto 0);
           busy 	: out   STD_LOGIC;
           valid 	: out   STD_LOGIC;
           en     : in   STD_LOGIC);
end spi_master;

architecture Behavioral of spi_master is
type state_type is (idle,transmit);
signal state: state_type:=idle;
signal buff_rx:STD_LOGIC_VECTOR (7 downto 0);
signal buff_tx:STD_LOGIC_VECTOR (7 downto 0);
signal i:integer range 0 to 7;
signal cnt:integer range 0 to 99;
begin

process(clk)
	begin
	if(rising_edge(clk)) then
		valid<='0';
		case state is
			when idle =>
				busy<='0';
				SS<='1';
				SCK<='0';
				if(en='1')then
					busy<='1';
					SS<='0';
					buff_tx <= din;
					state<=transmit;
					MOSI <= din(7);
				end if;
			when transmit =>
				cnt<=cnt+1;
				if(cnt=49) then  --faling edge
					sck<='1';
					buff_tx <= buff_tx(6 downto 0) & '0';
					
					buff_rx <= buff_rx(6 downto 0) & MISO;
				elsif(cnt=99) then
					cnt<=0;
					MOSI <= buff_tx(7);
					SCK<='0';
					i<=i+1;
					if(i=7)then
						state<=idle;
						valid<='1';
						SS<='1';
						dout<=buff_rx;
					end if;
				end if;
			end case;
	end if;
end process;

end Behavioral;


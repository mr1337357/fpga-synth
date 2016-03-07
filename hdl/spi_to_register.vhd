----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2016 11:54:36 AM
-- Design Name: 
-- Module Name: spi_to_register - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi_to_register is
    Port ( clk : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (7 downto 0);
           addr : out STD_LOGIC_VECTOR (7 downto 0);
           val : out STD_LOGIC_VECTOR (7 downto 0);
           we : out STD_LOGIC;
           valid : in STD_LOGIC;
           cs : in STD_LOGIC);
end spi_to_register;

architecture Behavioral of spi_to_register is
    SIGNAL is_address : STD_LOGIC := '1';
begin
    process(clk)
    begin
        if(clk'event and clk = '1')
        then
            if(cs = '1')
            then
                is_address <= '1';
                we <= '0';
            else
                if(valid = '1')
                then
                    if(is_address = '1')
                    then
                        is_address <= '0';
                        addr <= data;
                    else
                        we <= '1';
                        val <= data;
                    end if;
                else
                    we <= '0';
                end if;
            end if;
        end if;
    end process;

end Behavioral;

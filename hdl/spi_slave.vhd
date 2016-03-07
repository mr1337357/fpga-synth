----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2016 08:27:53 AM
-- Design Name: 
-- Module Name: spi_slave - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi_slave is
    Port ( clk : in STD_LOGIC;
           sck : in STD_LOGIC;
           sdi : in STD_LOGIC;
           cs : in STD_LOGIC;
           data : out STD_LOGIC_VECTOR (7 downto 0);
           wr : out STD_LOGIC);
end spi_slave;

architecture Behavioral of spi_slave is
    Signal sck_del : STD_LOGIC_VECTOR(1 downto 0) := "00";
    Signal sdi_del : STD_LOGIC_VECTOR(1 downto 0) := "00";
    Signal shift : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    Signal bit_count : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    Signal wr_int : STD_LOGIC := '0';
begin
    process(clk)
    begin
        if(clk'event and clk = '1')
        then
            wr <= wr_int;
            if(cs = '0')
            then
                sck_del <= sck_del(0) & sck;
                sdi_del <= sdi_del(0) & sdi;
                if(sck_del = "10")
                then
                    shift <= shift(6 downto 0) & sdi_del(1);
                    bit_count <= bit_count + 1;
                    if(bit_count = "1000")
                    then
                        bit_count <= "0001";
                        wr_int <= '1';
                        data <= shift;
                    else
                        wr_int <= '0';
                    end if;
                else
                    if(bit_count = "1000")
                    then
                        bit_count <= "0000";
                        wr_int <= '1';
                        data <= shift;
                    else
                        wr_int <= '0';
                    end if;
                end if;
            else
                shift <= "00000000";
                bit_count <= "0000";
                sck_del <= "00";
                sdi_del <= "00";
            end if;
        end if;
    end process;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity addr_decode is
   Port ( 
           clk : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (7 downto 0);
           cs : in STD_LOGIC;
           valid : in STD_LOGIC;
           sel : out STD_LOGIC_VECTOR(7 downto 0)
        );
end addr_decode;

architecture Behavioral of addr_decode is
   signal is_address : std_logic := '1';
   signal dec_addr : std_logic_vector(7 downto 0) := (others => '1');
begin

   sel <= dec_addr when cs = '0' else (others => '1');

   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(cs = '0')
         then
            is_address <= '1';
         else
            if(valid = '1' and is_address = '1')
            then
               case data(2 downto 0) is
                  when  "000" => dec_addr <= "11111110";
                  when  "001" => dec_addr <= "11111101";
                  when  "010" => dec_addr <= "11111011";
                  when  "011" => dec_addr <= "11110111";
                  when  "100" => dec_addr <= "11101111";
                  when  "101" => dec_addr <= "11011111";
                  when  "110" => dec_addr <= "10111111";
                  when  "111" => dec_addr <= "01111111";
                  when others => dec_addr <= "11111111";
               end case;
               is_address <= '0';
            end if;
         end if;
      end if;
   end process;

end Behavioral;
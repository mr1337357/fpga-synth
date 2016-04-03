library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity addr_decode is
   Port ( 
           clk : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (7 downto 0);
           cs : in STD_LOGIC;
           valid : in STD_LOGIC;
           sel : out STD_LOGIC_VECTOR(15 downto 0)
        );
end addr_decode;

architecture Behavioral of addr_decode is
   signal is_address : std_logic := '1';
   signal dec_addr : std_logic_vector(15 downto 0) := (others => '1');
begin

   sel <= dec_addr when cs = '0' else (others => '1');

   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(cs = '1')
         then
            is_address <= '1';
         else
            if(valid = '1' and is_address = '1')
            then
               case data(3 downto 0) is
                  when "0000" => dec_addr <= "1111111111111110";
                  when "0001" => dec_addr <= "1111111111111101";
                  when "0010" => dec_addr <= "1111111111111011";
                  when "0011" => dec_addr <= "1111111111110111";
                  when "0100" => dec_addr <= "1111111111101111";
                  when "0101" => dec_addr <= "1111111111011111";
                  when "0110" => dec_addr <= "1111111110111111";
                  when "0111" => dec_addr <= "1111111101111111";
                  when "1000" => dec_addr <= "1111111011111111";
                  when "1001" => dec_addr <= "1111110111111111";
                  when "1010" => dec_addr <= "1111101111111111";
                  when "1011" => dec_addr <= "1111011111111111";
                  when "1100" => dec_addr <= "1110111111111111";
                  when "1101" => dec_addr <= "1101111111111111";
                  when "1110" => dec_addr <= "1011111111111111";
                  when "1111" => dec_addr <= "0111111111111111";
                  when others => dec_addr <= "1111111111111111";
               end case;
               is_address <= '0';
            end if;
         end if;
      end if;
   end process;

end Behavioral;

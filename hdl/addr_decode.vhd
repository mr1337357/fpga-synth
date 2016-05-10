library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity addr_decode is
   Port ( 
           clk : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (7 downto 0);
           cs : in STD_LOGIC;
           valid : in STD_LOGIC;
           sel : out STD_LOGIC_VECTOR(31 downto 0)
        );
end addr_decode;

architecture Behavioral of addr_decode is
   signal is_address : std_logic := '1';
   signal dec_addr : std_logic_vector(31 downto 0) := (others => '1');
begin

   sel <= dec_addr when cs = '0' else (others => '1');

   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(cs = '1')
         then
            is_address <= '1';
            dec_addr <= (others => '1');
         else
            if(valid = '1' and is_address = '1')
            then
               case data(4 downto 0) is
                  when "00000"  => dec_addr <=  "11111111111111111111111111111110";
                  when "00001"  => dec_addr <=  "11111111111111111111111111111101";
                  when "00010"  => dec_addr <=  "11111111111111111111111111111011";
                  when "00011"  => dec_addr <=  "11111111111111111111111111110111";
                  when "00100"  => dec_addr <=  "11111111111111111111111111101111";
                  when "00101"  => dec_addr <=  "11111111111111111111111111011111";
                  when "00110"  => dec_addr <=  "11111111111111111111111110111111";
                  when "00111"  => dec_addr <=  "11111111111111111111111101111111";
                  when "01000"  => dec_addr <=  "11111111111111111111111011111111";
                  when "01001"  => dec_addr <=  "11111111111111111111110111111111";
                  when "01010"  => dec_addr <=  "11111111111111111111101111111111";
                  when "01011"  => dec_addr <=  "11111111111111111111011111111111";
                  when "01100"  => dec_addr <=  "11111111111111111110111111111111";
                  when "01101"  => dec_addr <=  "11111111111111111101111111111111";
                  when "01110"  => dec_addr <=  "11111111111111111011111111111111";
                  when "01111"  => dec_addr <=  "11111111111111110111111111111111";
                  when "10000"  => dec_addr <=  "11111111111111101111111111111111";
                  when "10001"  => dec_addr <=  "11111111111111011111111111111111";
                  when "10010"  => dec_addr <=  "11111111111110111111111111111111";
                  when "10011"  => dec_addr <=  "11111111111101111111111111111111";
                  when "10100"  => dec_addr <=  "11111111111011111111111111111111";
                  when "10101"  => dec_addr <=  "11111111110111111111111111111111";
                  when "10110"  => dec_addr <=  "11111111101111111111111111111111";
                  when "10111"  => dec_addr <=  "11111111011111111111111111111111";
                  when "11000"  => dec_addr <=  "11111110111111111111111111111111";
                  when "11001"  => dec_addr <=  "11111101111111111111111111111111";
                  when "11010"  => dec_addr <=  "11111011111111111111111111111111";
                  when "11011"  => dec_addr <=  "11110111111111111111111111111111";
                  when "11100"  => dec_addr <=  "11101111111111111111111111111111";
                  when "11101"  => dec_addr <=  "11011111111111111111111111111111";
                  when "11110"  => dec_addr <=  "10111111111111111111111111111111";
                  when "11111"  => dec_addr <=  "01111111111111111111111111111111";
                  when others   => dec_addr <= (others => '1');
               end case;
               is_address <= '0';
            end if;
         end if;
      end if;
   end process;

end Behavioral;

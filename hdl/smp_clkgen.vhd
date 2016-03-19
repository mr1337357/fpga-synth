library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity smp_clkgen is
   Generic( in_freq : INTEGER := 50000000;
           out_freq : INTEGER := 65536);
   Port ( clk : in STD_LOGIC;
      smp_clk : out STD_LOGIC);
end smp_clkgen;

architecture Behavioral of smp_clkgen is
   Signal counter : INTEGER := 0;
   Signal clkdiv : INTEGER := in_freq / out_freq;
begin

   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(counter = clkdiv)
         then
            counter <= 0;
            smp_clk <= '1';
         else
            counter <= counter + 1;
            smp_clk <= '0';
         end if;
      end if;
   end process;

end Behavioral;

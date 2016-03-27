library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pwm is
   Generic ( 
   clkdiv : INTEGER
);
Port (
        clk : in STD_LOGIC;
           --sample input
        smp_in : in STD_LOGIC_VECTOR (7 downto 0);
        smp_val_in : in STD_LOGIC;
           -- misc
        wave_out : out STD_LOGIC;
);
end pwm;

architecture Behavioral of pwm is
   signal clk_counter : STD_LOGIC_VECTOR(7 downto 0);
   signal out_counter : STD_LOGIC_VECTOR(7 downto 0);
begin
   p1: PROCESS(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(resetn = '0')
         then 
            clk_counter <= "00000000";
            out_counter <= "00000000";
         else
            if(clk_counter < clkdiv)
            then
               clk_counter <= clk_counter + '1';
               out_counter <= out_counter;
            else
               clk_counter <= "00000000";
               out_counter <= out_counter + '1';
            end if;
         end if;
         if(out_counter <= duty)
                           then 
                              wave_out <= '1';
                           else
                              wave_out <= '0';
                           end if;
      end if;
   end process;

end Behavioral;

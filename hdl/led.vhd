library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity leds is
   Port (
           clk : in STD_LOGIC;
           --control
           cs : in STD_LOGIC;
           ctl_val : in STD_LOGIC;
           ctl_in : in STD_LOGIC_VECTOR(7 downto 0);
		   --misc
		   leds : out STD_LOGIC_VECTOR(15 downto 0)
        );
end leds;

architecture Behavioral of leds is
   Signal led_state : STD_LOGIC := '0';
   Signal led_temp : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
begin

   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(cs = '0')
         then
            if(ctl_val = '1' and led_state = '0')
            then
               led_state <= '1';
               led_temp <= ctl_in;
            end if;
            if(ctl_val = '1' and led_state = '1')
            then
               leds <=led_temp & ctl_in;
            end if;
         else
            led_state <= '0';
         end if;
      end if;
   end process;

end Behavioral;

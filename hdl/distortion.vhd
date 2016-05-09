library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity distortion is
   Port (     
           clk : in STD_LOGIC;
           --sample input
           smp_in : in STD_LOGIC_VECTOR(7 downto 0);
           smp_val_in : in STD_LOGIC;
           --sample output
           smp_out : out STD_LOGIC_VECTOR(7 downto 0);
           smp_val_out : out STD_LOGIC;
           --control
           ctl_val : in STD_LOGIC;
           ctl_in : in STD_LOGIC_VECTOR(7 downto 0)
        );
end distortion;

architecture Behavioral of distortion is

   Signal smp_sgn : STD_LOGIC_VECTOR(7 downto 0);
   Signal max : STD_LOGIC_VECTOR(7 downto 0);
   Signal min : STD_LOGIC_VECTOR(7 downto 0);
   Signal output : STD_LOGIC_VECTOR(7 downto 0);

begin

   output <= max when (smp_in > max) else
             min when (smp_in < min) else
             smp_in;

   process(clk)
   begin
      if(clk'event and clk = '1')
      then
        if(ctl_val = '1')
        then
           max <= x"80"+ctl_in;
           min <= x"80"-ctl_in;
        end if;
      end if;
   end process;
   
   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(smp_val_in = '1')
         then
            smp_out <= output;
            smp_val_out <= '1';
         else
            smp_val_out <= '0';
         end if;
      end if;
   end process;

end Behavioral;

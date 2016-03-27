library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity volctl is
   Port (     
           clk : in STD_LOGIC;
              --sample input
           smp_in : in STD_LOGIC_VECTOR(7 downto 0);
           smp_val_in : in STD_LOGIC;
              --sample output
           smp_out : out STD_LOGIC_VECTOR(7 downto 0);
           smp_val_out : out STD_LOGIC;
              --control
           cs : in STD_LOGIC;
           ctl_val : in STD_LOGIC;
           ctl_in : in STD_LOGIC_VECTOR(7 downto 0)
        );
end volctl;

architecture Behavioral of volctl is
   Signal amp : STD_LOGIC_VECTOR(3 downto 0) := "0000";
   Signal mul : STD_LOGIC_VECTOR(11 downto 0);
begin
   smp_out <= mul(11 downto 4);
   mul <= smp_in * amp;

   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(amp_wr = '1')
         then
            amp <= amp_in;
         end if;
      end if;
   end process;

end Behavioral;

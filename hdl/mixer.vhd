library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mixer is
   Port (     
           clk : in STD_LOGIC;
           --sample input
           smp_in_1 : in STD_LOGIC_VECTOR(7 downto 0);
           smp_val_in_1 : in STD_LOGIC;
           --sample input
           smp_in_2 : in STD_LOGIC_VECTOR(7 downto 0);
           smp_val_in_2 : in STD_LOGIC;
           --sample input
           smp_in_3 : in STD_LOGIC_VECTOR(7 downto 0);
           smp_val_in_3 : in STD_LOGIC;
           --sample input
           smp_in_4 : in STD_LOGIC_VECTOR(7 downto 0);
           smp_val_in_4 : in STD_LOGIC;
           --sample output
           smp_out : out STD_LOGIC_VECTOR(7 downto 0);
           smp_val_out : out STD_LOGIC;
           --control
           smp_clk : in STD_LOGIC
        );
end mixer;

architecture Behavioral of mixer is

   Signal smp_1 : STD_LOGIC_VECTOR(7 downto 0);
   Signal smp_2 : STD_LOGIC_VECTOR(7 downto 0);
   Signal smp_3 : STD_LOGIC_VECTOR(7 downto 0);
   Signal smp_4 : STD_LOGIC_VECTOR(7 downto 0);
   Signal sum : STD_LOGIC_VECTOR(9 downto 0);

begin
   
   sum <= ("00"&smp_1)+("00"&smp_2)+("00"&smp_3)+("00"&smp_4);

   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(smp_val_in_1 = '1')
         then
            smp_1 <= (not smp_in_1(7)) & smp_in_1(6 downto 0);
         end if;
      end if;
   end process;
   
   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(smp_val_in_2 = '1')
         then
            smp_2 <= (not smp_in_2(7)) & smp_in_2(6 downto 0);
         end if;
      end if;
   end process;
   
   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(smp_val_in_3 = '1')
         then
            smp_3 <= (not smp_in_3(7)) & smp_in_3(6 downto 0);
         end if;
      end if;
   end process;
   
   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(smp_val_in_4 = '1')
         then
            smp_4 <= (not smp_in_4(7)) & smp_in_4(6 downto 0);
         end if;
      end if;
   end process;
   
   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(smp_clk = '1')
         then
            smp_val_out <= '1';
            smp_out <= (not sum(9)) & sum(8 downto 2);
         else
            smp_val_out <= '0';
         end if;
      end if;
   end process;
   
end Behavioral;

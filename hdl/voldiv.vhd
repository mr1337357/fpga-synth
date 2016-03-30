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

component mult is
   Port (
            a : in STD_LOGIC_VECTOR(7 downto 0);
            b : in STD_LOGIC_VECTOR(4 downto 0);
            o : out STD_LOGIC_VECTOR(7 downto 0)
        );
end component;

   Signal smp_sgn : STD_LOGIC_VECTOR(7 downto 0);
   Signal amp : STD_LOGIC_VECTOR(4 downto 0) := "00100";
   Signal mul : STD_LOGIC_VECTOR(7 downto 0);
   Signal output : STD_LOGIC_VECTOR(7 downto 0);

begin
   smp_sgn <=(not smp_in(7)) & smp_in(6 downto 0);
   m1 : mult
    port map (
        a => smp_sgn,
        b => amp,
        o => mul
        );
   output <= (not mul(7)) & mul(6 downto 0);

   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(cs = '0')
         then
            if(ctl_val = '1')
            then
               amp <= ctl_in(4 downto 0);
            end if;
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

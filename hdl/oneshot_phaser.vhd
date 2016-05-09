library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity oneshot_phaser is
   Port (
           clk : in STD_LOGIC;
              --sample in
           smp_val_in : in STD_LOGIC;
              --sample out
           smp_out : out STD_LOGIC_VECTOR(7 downto 0);
           smp_val_out : out STD_LOGIC;
              --control
           ctl_val : in STD_LOGIC;
           ctl_in : in STD_LOGIC_VECTOR(15 downto 0)
        );
end oneshot_phaser;

architecture Behavioral of oneshot_phaser is
   Signal int_phase : STD_LOGIC_VECTOR(16 downto 0) := (others => '0');
   Signal int_freq : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
   Signal freq_temp : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
begin
   smp_out <= int_phase(15 downto 8);



   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(ctl_val = '1')
         then
            int_freq <= ctl_in;
            int_phase <= (others => '0');
         elsif(smp_val_in = '1')
         then
            if(int_phase(16)='0')
            then
                int_phase <= int_phase + ('0' & int_freq);
            end if;
            smp_val_out <= '1';
         else
            smp_val_out <= '0';
         end if;
      end if;
   end process;
end Behavioral;

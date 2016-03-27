library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity phase_acc is
   Port (
           clk : in STD_LOGIC;
              --sample in
           smp_val_in : in STD_LOGIC;
              --sample out
           smp_out : out STD_LOGIC_VECTOR(7 downto 0);
           smp_val_out : out STD_LOGIC;
              --control
           cs : in STD_LOGIC;
           ctl_val : in STD_LOGIC;
           ctl_in : in STD_LOGIC_VECTOR(7 downto 0)
        );
end phase_acc;

architecture Behavioral of phase_acc is
   Signal int_phase : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
   Signal int_freq : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
   Signal freq_state : STD_LOGIC := '0';
   Signal freq_temp : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
begin
   phase_out <= int_phase(15 downto 8);

   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(smp_clk = '1')
         then
            int_phase <= int_phase + int_freq;
         end if;
      end if;
   end process;

   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(cs = '0')
         then
            if(in_wr = '1' and freq_state = '0')
            then
               freq_state <= '1';
               freq_temp <= in_freq;
            end if;
            if(in_wr = '1' and freq_state = '1')
            then
               int_freq <=freq_temp & in_freq;
            end if;
         else
            freq_state <= '0';
         end if;
      end if;
   end process;

end Behavioral;
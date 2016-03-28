library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lut is
   Port(     
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
end lut;

architecture Behavioral of lut is
   type RAM is array(255 downto 0) of std_logic_vector(7 downto 0);
   Signal mem : RAM := (others => (others => '0'));
   Signal write_addr : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
   Signal rd_index : unsigned;
   Signal wr_index : unsigned;
begin
   rd_index <= to_unsigned(phase_in);
   wr_index <= to_unsigned(write_addr);
   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         smp_out <= mem(rd_index);
      end if;
   end process;

   process(clk)
   begin
      if(clk'event and clk = '1')
      then
         if(cs = '0')
         then
            if(smp_valid = '1')
            then
               mem(wr_index) <= smp_in;
               write_addr <= write_addr + 1;
            end if;
         else
            write_addr <= (others => '0');
         end if;
      end if;
   end process;
end Behavioral;

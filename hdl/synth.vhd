library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity synth is
   port ( clk   : in    std_logic; 
          cs    : in    std_logic; 
          sck   : in    std_logic; 
          sdi   : in    std_logic; 
          l_out : out   std_logic; 
          r_out : out   std_logic);
end synth;

architecture BEHAVIORAL of synth is
   signal chan_val_l_1  : std_logic;
   signal chan_val_l_2  : std_logic;
   signal chan_val_l_3  : std_logic;
   signal chan_val_l_4  : std_logic;
   signal chan_val_r_1  : std_logic;
   signal chan_val_r_2  : std_logic;
   signal chan_val_r_3  : std_logic;
   signal chan_val_r_4  : std_logic;
   signal chan_l_1      : std_logic_vector (7 downto 0);
   signal chan_l_2      : std_logic_vector (7 downto 0);
   signal chan_l_3      : std_logic_vector (7 downto 0);
   signal chan_l_4      : std_logic_vector (7 downto 0);
   signal chan_r_1      : std_logic_vector (7 downto 0);
   signal chan_r_2      : std_logic_vector (7 downto 0);
   signal chan_r_3      : std_logic_vector (7 downto 0);
   signal chan_r_4      : std_logic_vector (7 downto 0);
   signal perc_phase    : std_logic_vector (7 downto 0);
   signal perc_phas_val : std_logic;
   signal perc_sig      : std_logic_vector (7 downto 0);
   signal perc_val      : std_logic;
   signal data        : std_logic_vector (7 downto 0);
   signal l_dat       : std_logic_vector (7 downto 0);
   signal l_val       : std_logic;
   signal phase_dat_1 : std_logic_vector (7 downto 0);
   signal phase_dat_2 : std_logic_vector (7 downto 0);
   signal phase_dat_3 : std_logic_vector (7 downto 0);
   signal phase_dat_4 : std_logic_vector (7 downto 0);
   signal phs_val_1   : std_logic;
   signal phs_val_2   : std_logic;
   signal phs_val_3   : std_logic;
   signal phs_val_4   : std_logic;
   signal r_dat       : std_logic_vector (7 downto 0);
   signal r_val       : std_logic;
   signal sel         : std_logic_vector (19 downto 0);
   signal smp_clk     : std_logic;
   signal valid       : std_logic;
   signal wave_val_1  : std_logic;
   signal wave_val_2  : std_logic;
   signal wave_val_3  : std_logic;
   signal wave_val_4  : std_logic;
   signal wave_1      : std_logic_vector (7 downto 0);
   signal wave_2      : std_logic_vector (7 downto 0);
   signal wave_3      : std_logic_vector (7 downto 0);
   signal wave_4      : std_logic_vector (7 downto 0);
   component addr_decode
      port ( clk   : in    std_logic; 
             cs    : in    std_logic; 
             valid : in    std_logic; 
             data  : in    std_logic_vector (7 downto 0); 
             sel   : out   std_logic_vector (19 downto 0));
   end component;
   
   component lut
      port ( clk         : in    std_logic; 
             smp_val_in  : in    std_logic; 
             cs          : in    std_logic; 
             ctl_val     : in    std_logic; 
             smp_in      : in    std_logic_vector (7 downto 0); 
             ctl_in      : in    std_logic_vector (7 downto 0); 
             smp_val_out : out   std_logic; 
             smp_out     : out   std_logic_vector (7 downto 0));
   end component;
   
   component mixer
      port ( clk          : in    std_logic; 
             smp_val_in_1 : in    std_logic; 
             smp_val_in_2 : in    std_logic; 
             smp_val_in_3 : in    std_logic;
             smp_val_in_4 : in    std_logic;
             smp_val_in_5 : in    std_logic;
             smp_clk      : in    std_logic; 
             smp_in_1     : in    std_logic_vector (7 downto 0); 
             smp_in_2     : in    std_logic_vector (7 downto 0); 
             smp_in_3     : in    std_logic_vector (7 downto 0);
             smp_in_4     : in    std_logic_vector (7 downto 0);
             smp_in_5     : in    std_logic_vector (7 downto 0);
             smp_val_out  : out   std_logic; 
             smp_out      : out   std_logic_vector (7 downto 0));
   end component;
   
   component pwm
      port ( clk        : in    std_logic; 
             smp_val_in : in    std_logic; 
             smp_in     : in    std_logic_vector (7 downto 0); 
             wave_out   : out   std_logic);
   end component;
   
   component phase_acc
      port ( clk         : in    std_logic; 
             smp_val_in  : in    std_logic; 
             cs          : in    std_logic; 
             ctl_val     : in    std_logic; 
             ctl_in      : in    std_logic_vector (7 downto 0); 
             smp_val_out : out   std_logic; 
             smp_out     : out   std_logic_vector (7 downto 0));
   end component;
   
   component spi_slave
      port ( clk  : in    std_logic; 
             sck  : in    std_logic; 
             sdi  : in    std_logic; 
             cs   : in    std_logic; 
             wr   : out   std_logic; 
             data : out   std_logic_vector (7 downto 0));
   end component;
   
   component smp_clkgen
      port ( clk     : in    std_logic; 
             smp_clk : out   std_logic);
   end component;
   
   component volctl
      port ( clk         : in    std_logic; 
             smp_val_in  : in    std_logic; 
             cs          : in    std_logic; 
             ctl_val     : in    std_logic; 
             smp_in      : in    std_logic_vector (7 downto 0); 
             ctl_in      : in    std_logic_vector (7 downto 0); 
             smp_val_out : out   std_logic; 
             smp_out     : out   std_logic_vector (7 downto 0));
   end component;
   
   component oneshot_phaser
      port ( clk         : in    std_logic; 
             smp_val_in  : in    std_logic; 
             cs          : in    std_logic; 
             ctl_val     : in    std_logic; 
             ctl_in      : in    std_logic_vector (7 downto 0); 
             smp_val_out : out   std_logic; 
             smp_out     : out   std_logic_vector (7 downto 0));
   end component;
   
begin
   decoder : addr_decode
      port map (clk=>clk,
                cs=>cs,
                data(7 downto 0)=>data(7 downto 0),
                valid=>valid,
                sel(19 downto 0)=>sel(19 downto 0));
   
   lut_1 : lut
      port map (clk=>clk,
                cs=>sel(4),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_in(7 downto 0)=>phase_dat_1(7 downto 0),
                smp_val_in=>phs_val_1,
                smp_out(7 downto 0)=>wave_1(7 downto 0),
                smp_val_out=>wave_val_1);
   
   lut_2 : lut
      port map (clk=>clk,
                cs=>sel(5),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_in(7 downto 0)=>phase_dat_2(7 downto 0),
                smp_val_in=>phs_val_2,
                smp_out(7 downto 0)=>wave_2(7 downto 0),
                smp_val_out=>wave_val_2);
   
   lut_3 : lut
      port map (clk=>clk,
                cs=>sel(6),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_in(7 downto 0)=>phase_dat_3(7 downto 0),
                smp_val_in=>phs_val_3,
                smp_out(7 downto 0)=>wave_3(7 downto 0),
                smp_val_out=>wave_val_3);
   
   lut_4 : lut
      port map (clk=>clk,
                cs=>sel(7),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_in(7 downto 0)=>phase_dat_4(7 downto 0),
                smp_val_in=>phs_val_4,
                smp_out(7 downto 0)=>wave_4(7 downto 0),
                smp_val_out=>wave_val_4);
   
   l_mix : mixer
      port map (clk=>clk,
                smp_clk=>smp_clk,
                smp_in_1(7 downto 0)=>chan_l_1(7 downto 0),
                smp_in_2(7 downto 0)=>chan_l_2(7 downto 0),
                smp_in_3(7 downto 0)=>chan_l_3(7 downto 0),
                smp_in_4(7 downto 0)=>chan_l_4(7 downto 0),
                smp_in_5(7 downto 0)=>perc_sig,
                smp_val_in_1=>chan_val_l_1,
                smp_val_in_2=>chan_val_l_2,
                smp_val_in_3=>chan_val_l_3,
                smp_val_in_4=>chan_val_l_4,
                smp_val_in_5=>perc_val,
                smp_out(7 downto 0)=>l_dat(7 downto 0),
                smp_val_out=>l_val);
   
   l_pwm : pwm
      port map (clk=>clk,
                smp_in(7 downto 0)=>l_dat(7 downto 0),
                smp_val_in=>l_val,
                wave_out=>l_out);
   
   phase_1 : phase_acc
      port map (clk=>clk,
                cs=>sel(0),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_val_in=>smp_clk,
                smp_out(7 downto 0)=>phase_dat_1(7 downto 0),
                smp_val_out=>phs_val_1);
   
   phase_2 : phase_acc
      port map (clk=>clk,
                cs=>sel(1),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_val_in=>smp_clk,
                smp_out(7 downto 0)=>phase_dat_2(7 downto 0),
                smp_val_out=>phs_val_2);
   
   phase_3 : phase_acc
      port map (clk=>clk,
                cs=>sel(2),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_val_in=>smp_clk,
                smp_out(7 downto 0)=>phase_dat_3(7 downto 0),
                smp_val_out=>phs_val_3);
   
   phase_4 : phase_acc
      port map (clk=>clk,
                cs=>sel(3),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_val_in=>smp_clk,
                smp_out(7 downto 0)=>phase_dat_4(7 downto 0),
                smp_val_out=>phs_val_4);
   
   r_mix : mixer
      port map (clk=>clk,
                smp_clk=>smp_clk,
                smp_in_1(7 downto 0)=>chan_r_1(7 downto 0),
                smp_in_2(7 downto 0)=>chan_r_2(7 downto 0),
                smp_in_3(7 downto 0)=>chan_r_3(7 downto 0),
                smp_in_4(7 downto 0)=>chan_r_4(7 downto 0),
                smp_in_5(7 downto 0)=>perc_sig,
                smp_val_in_1=>chan_val_r_1,
                smp_val_in_2=>chan_val_r_2,
                smp_val_in_3=>chan_val_r_3,
                smp_val_in_4=>chan_val_r_4,
                smp_val_in_5=>perc_val,
                smp_out(7 downto 0)=>r_dat(7 downto 0),
                smp_val_out=>r_val);
   
   r_pwm : pwm
      port map (clk=>clk,
                smp_in(7 downto 0)=>r_dat(7 downto 0),
                smp_val_in=>r_val,
                wave_out=>r_out);
   
   slave : spi_slave
      port map (clk=>clk,
                cs=>cs,
                sck=>sck,
                sdi=>sdi,
                data(7 downto 0)=>data(7 downto 0),
                wr=>valid);
   
   smp_clock : smp_clkgen
      port map (clk=>clk,
                smp_clk=>smp_clk);
   
   vol_l_1 : volctl
      port map (clk=>clk,
                cs=>sel(8),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_in(7 downto 0)=>wave_1(7 downto 0),
                smp_val_in=>wave_val_1,
                smp_out(7 downto 0)=>chan_l_1(7 downto 0),
                smp_val_out=>chan_val_l_1);
   
   vol_l_2 : volctl
      port map (clk=>clk,
                cs=>sel(9),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_in(7 downto 0)=>wave_2(7 downto 0),
                smp_val_in=>wave_val_2,
                smp_out(7 downto 0)=>chan_l_2(7 downto 0),
                smp_val_out=>chan_val_l_2);
   
   vol_l_3 : volctl
      port map (clk=>clk,
                cs=>sel(10),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_in(7 downto 0)=>wave_3(7 downto 0),
                smp_val_in=>wave_val_3,
                smp_out(7 downto 0)=>chan_l_3(7 downto 0),
                smp_val_out=>chan_val_l_3);
   
   vol_l_4 : volctl
      port map (clk=>clk,
                cs=>sel(11),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_in(7 downto 0)=>wave_4(7 downto 0),
                smp_val_in=>wave_val_4,
                smp_out(7 downto 0)=>chan_l_4(7 downto 0),
                smp_val_out=>chan_val_l_4);
                

   vol_r_1 : volctl
      port map (clk=>clk,
                cs=>sel(12),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_in(7 downto 0)=>wave_1(7 downto 0),
                smp_val_in=>wave_val_1,
                smp_out(7 downto 0)=>chan_r_1(7 downto 0),
                smp_val_out=>chan_val_r_1);

   vol_r_2 : volctl
      port map (clk=>clk,
                cs=>sel(13),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_in(7 downto 0)=>wave_2(7 downto 0),
                smp_val_in=>wave_val_2,
                smp_out(7 downto 0)=>chan_r_2(7 downto 0),
                smp_val_out=>chan_val_r_2);
   
   vol_r_3 : volctl
      port map (clk=>clk,
                cs=>sel(14),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_in(7 downto 0)=>wave_3(7 downto 0),
                smp_val_in=>wave_val_3,
                smp_out(7 downto 0)=>chan_r_3(7 downto 0),
                smp_val_out=>chan_val_r_3);
   
   vol_r_4 : volctl
      port map (clk=>clk,
                cs=>sel(15),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_in(7 downto 0)=>wave_4(7 downto 0),
                smp_val_in=>wave_val_4,
                smp_out(7 downto 0)=>chan_r_4(7 downto 0),
                smp_val_out=>chan_val_r_4);
   drum_phase : oneshot_phaser
      port map (clk=>clk,
                cs=>sel(16),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_val_in=>smp_clk,
                smp_out(7 downto 0)=>perc_phase(7 downto 0),
                smp_val_out=>perc_phas_val);
   drum_smp : lut
      port map (clk=>clk,
                cs=>sel(17),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_in(7 downto 0)=>perc_phase,
                smp_val_in=>perc_phas_val,
                smp_out(7 downto 0)=>perc_sig,
                smp_val_out=>perc_val);
   
end BEHAVIORAL;